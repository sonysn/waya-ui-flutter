import 'package:flutter/material.dart';
import '../../../colorscheme.dart';
import 'package:waya/widgets/my_card.dart';
import 'package:waya/widgets/transaction_card.dart';
import 'package:waya/screens/transactionhistory.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);


  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {


  @override
  Widget build(BuildContext context) {
  return Scaffold(

  body: SingleChildScrollView(
  physics: ClampingScrollPhysics(),
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
  physics: ClampingScrollPhysics(),
  separatorBuilder: (context, index) {
  return SizedBox(
  width: 8,
  );
  },
  itemCount: 1,
  shrinkWrap: true,
  scrollDirection: Axis.horizontal,
  itemBuilder: (context, index) {
  return MyCard(

  );
  }),
  ),

    SizedBox(
      height: 30,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              // navigate to deposit page or function
            },
            child: Column(
              children: [
                Icon(Icons.money, size: 40),
                SizedBox(height: 10),
                Text("Deposit"),
              ],
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: InkWell(
            onTap: () {
              // navigate to withdrawal page or function
            },
            child: Column(
              children: [
                Icon(Icons.money_off_csred, size: 40),
                SizedBox(height: 10),
                Text("Withdraw"),
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
                child: Text("View all",style: TextStyle(

                    color: customPurple)),
              ),
            )
        ),
      ],
    ),SizedBox(
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
  return TransactionCard();})
  ],
  ),
  ),
  ),
  );
  }
  }
