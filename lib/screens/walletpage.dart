import 'dart:async';

import 'package:flutter/material.dart';
import '../../../colorscheme.dart';
import 'package:waya/widgets/my_card.dart';
import 'package:waya/widgets/transaction_card.dart';
import 'package:waya/screens/transactionhistory.dart';
import 'package:waya/screens/transfers.dart';
import '../api/actions.dart';
import 'cash_deposit_page.dart';

class WalletPage extends StatefulWidget {
  final dynamic data;

  const WalletPage({Key? key, this.data}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final _streamController = StreamController<String>.broadcast();

  Stream<String> get stream => _streamController.stream;

  Future _getAccountBalance() async {
    final response = await getBalance(widget.data.id, widget.data.phoneNumber);
    print(response);
    _streamController.add(response);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAccountBalance();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _getAccountBalance,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 180,
                  child: ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 8,
                        );
                      },
                      itemCount: 1,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return MyCard(data: widget.data, stream: stream);
                      }),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // navigate to deposit page or function
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return CashDepositPage(
                                  id: widget.data.id,
                                  phone: widget.data.phoneNumber,
                                  email: widget.data.email,
                                );
                              },
                            ),
                          );
                        },
                        child: Column(
                          children: const [
                            Icon(Icons.account_balance_wallet, size: 40),
                            SizedBox(height: 10),
                            Text("Deposit", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // navigate to transfer page or function
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return TransferPage(phoneNumber: widget.data.phoneNumber);
                              },
                            ),
                          );
                        },
                        child: Column(
                          children: const [
                            Icon(Icons.send, size: 40),
                            SizedBox(height: 10),
                            Text("Transfer", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Recent Transactions"),
                    Flexible(
                        child: Container(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return const TransactionHistory();
                        })),
                        child: Text("View all",
                            style: TextStyle(color: customPurple)),
                      ),
                    )),
                  ],
                ),
                SizedBox(
                  height: 0,
                ),
                ListView.separated(
                    itemCount: 6,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemBuilder: (context, index) {
                      return TransactionCard();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
