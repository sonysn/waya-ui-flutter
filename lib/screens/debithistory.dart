import 'package:flutter/material.dart';
import 'package:qunot/screens/widgets/debit_card.dart';

class DebitHistory extends StatefulWidget {
  final dynamic data;
  final List debits;

  const DebitHistory({Key? key, this.data, required this.debits})
      : super(key: key);

  @override
  State<DebitHistory> createState() => _DebitHistoryState();
}

class _DebitHistoryState extends State<DebitHistory> {
  List reversedTransactions = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      reversedTransactions = widget.debits.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 10),
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
                'Earning History',
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
          widget.debits.isNotEmpty
              ? Container(
                  padding: const EdgeInsets.only(top: 40),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.separated(
                        itemCount: widget.debits.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 10);
                        },
                        itemBuilder: (context, index) {
                          return DebitCard(
                            amountTransferred: reversedTransactions[index]
                                ['amountTransferred'],
                            dateTransferred: reversedTransactions[index]
                                ['datePaid'],
                          );
                        },
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Container(
                    margin: const EdgeInsets.all(45),
                    child: const Text(
                      'No Earnings Yet',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
