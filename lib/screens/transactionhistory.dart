import 'package:flutter/material.dart';
import 'package:waya/screens/widgets/transaction_card.dart';

class TransactionHistory extends StatefulWidget {
  final dynamic data;
  final List transactions;

  const TransactionHistory({Key? key, this.data, required this.transactions}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List reversedTransactions = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    setState(() {
      reversedTransactions = widget.transactions.reversed.toList();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black, // Set the tab bar color to black
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 25,
              color: Colors.white, // Set the arrow icon color to white
            ),
          ),
          title: const Text(
            'Transaction History',
            style: TextStyle(fontSize: 30),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Deposit History'),
              Tab(text: 'User Transfer History'),
              Tab(text: 'Driver Transfer History'),
              Tab(text: 'Money Received History'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
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
            // Add other TabBarView children here for the remaining tabs
          ],
        ),
      ),
    );
  }
}
