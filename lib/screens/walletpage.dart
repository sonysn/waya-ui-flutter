import 'dart:async';

import 'package:flutter/material.dart';
import 'package:waya/api/actions.dart';
import 'package:waya/api/payments.dart';
import 'package:waya/screens/cash_deposit_page.dart';
import 'package:waya/screens/transfers.dart';
import '../../../colorscheme.dart';
import 'package:waya/screens/widgets/transaction_card.dart';
import 'package:waya/screens/transactionhistory.dart';
import 'package:waya/screens/widgets/my_card.dart';


class WalletPage extends StatefulWidget {
  final dynamic data;
  const WalletPage({Key? key, this.data}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final _streamController = StreamController<String>.broadcast();

  Stream<String> get stream => _streamController.stream;
  List earnings = [];
  //bring the most recent from the server on reqest
  List reversedEarnings = [];
  List transactions = [];
  List reversedTransactions = [];

  Future _getAccountBalance() async {
    final response = await getBalance(widget.data.id, widget.data.phoneNumber);
    debugPrint(response);
    _streamController.add(response);
  }


  //TODO BY STEPHEN
  //Future _getDepositTransactions() async {
  //  final response = await getDepositHistory(userID: widget.data.id);
    //print(response);
   // setState(() {
    //  transactions.addAll(response);
    //  reversedTransactions = transactions.reversed.toList();
   // });
 // }

  @override
  void initState() {
    super.initState();
    _getAccountBalance();
    //_getDepositTransactions();  TODO BY STEPHEN
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
                SizedBox(
                  height: 180,
                  child: ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 8,
                      );
                    },
                    itemCount: 1,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return MyCard(data: widget.data, stream: stream);
                    },
                  ),
                ),
                const SizedBox(
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
                                return TransferPage(
                                    phoneNumber: widget.data.phoneNumber);
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
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Recent Transactions"),
                    Flexible(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return TransactionHistory(
                                  data: widget.data,
                                  transactions: transactions,
                                );
                              },
                            ),
                          ),
                          child: const Text(
                            "View all",
                            style: TextStyle(color: customPurple),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 0,
                ),
                transactions.isNotEmpty
                    ? ListView.separated(
                  itemCount: transactions.length > 3 ? 3 : transactions.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemBuilder: (context, index) {
                    return TransactionCard(
                      data: widget.data,
                      depositAmount:
                      reversedTransactions[index]['data']['amount'] / 100,
                      depositDate: reversedTransactions[index]['data']['paid_at'],
                    );
                  },
                )
                    : Center(
                  child: Container(
                    margin: const EdgeInsets.all(45),
                    child: const Text(
                      'No Transactions Yet',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}