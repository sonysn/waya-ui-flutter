import 'package:flutter/material.dart';
import 'package:waya/screens/widgets/transaction_card.dart';

class TransactionHistory extends StatefulWidget {
  final dynamic data;
  final List transactions;

  const TransactionHistory({Key? key, this.data, required this.transactions}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  List reversedTransactions = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      reversedTransactions = widget.transactions.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 25,
                  color: Colors.black,
                ),
              ),
              const Text(
                'Transaction History',
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 40),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.transactions.isEmpty
                    ? const Center(
                  child: Text(
                    'No transactions',
                    style: TextStyle(fontSize: 20),
                  ),
                )
                    : ListView.separated(
                  itemCount: widget.transactions.length,
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
                      depositAmount: reversedTransactions[index]['data']['amount'] / 100,
                      depositDate: reversedTransactions[index]['data']['paid_at'],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
