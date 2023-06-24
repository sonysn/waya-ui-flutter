import 'package:flutter/material.dart';
import 'package:waya/screens/widgets/transaction_card.dart';
import 'package:waya/screens/widgets/debit_card.dart';

class TransactionHistory extends StatefulWidget {
  final dynamic data;
  final List deposits;
  final List debits;
  final List userToDriverTransactions;
  const TransactionHistory(
      {Key? key,
      this.data,
      required this.deposits,
      required this.debits,
      required this.userToDriverTransactions})
      : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List reversedDeposits = [];
  List reversedUserToDriverTransactions = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    setState(() {
      reversedDeposits = widget.deposits.reversed.toList();
      reversedUserToDriverTransactions =
          widget.userToDriverTransactions.reversed.toList();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ignore: unused_element
  Future<void> _refreshData() async {
    // Implement your refresh logic here
    // For example, fetch updated transaction data from an API
    // Once you have the updated data, update the 'transactions' list and call 'setState'
    await Future.delayed(const Duration(seconds: 2)); // Simulating a delay

    setState(() {
      // Update 'transactions' list with new data
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
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
              Tab(text: 'Deposits'),
              Tab(text: 'Rider Transfers'),
              Tab(text: 'Driver Transfers'),
              Tab(text: 'Credits'),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            // Implement your refresh logic here
            // For example, fetch updated transaction data from an API
            // Once you have the updated data, update the 'reversedTransactions' list and call 'setState'
            await Future.delayed(
                const Duration(seconds: 2)); // Simulating a delay

            setState(() {
              reversedDeposits = widget.deposits.reversed.toList();
            });
          },
          color: Colors.orange, // Set the refresh indicator color to orange
          child: TabBarView(
            controller: _tabController,
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(top: 40),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.deposits.isEmpty
                          ? const Center(
                              child: Text(
                                'No transactions',
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          : ListView.separated(
                              itemCount: widget.deposits.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              itemBuilder: (context, index) {
                                return TransactionCard(
                                  depositAmount: reversedDeposits[index]['data']
                                          ['amount'] /
                                      100,
                                  depositDate: reversedDeposits[index]['data']
                                      ['paid_at'],
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
              // User Transfer History Tab
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(top: 40),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.debits.isEmpty
                          ? const Center(
                              child: Text(
                                'No transactions',
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          : ListView.separated(
                              itemCount: widget.debits.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              itemBuilder: (context, index) {
                                return DebitCard(
                                  amountTransferred: reversedDeposits[index]
                                      ['amountTransferred'],
                                  dateTransferred: reversedDeposits[index]
                                      ['datePaid'],
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
              // Driver Transfer History Tab
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(top: 40),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.userToDriverTransactions.isEmpty
                          ? const Center(
                              child: Text(
                              'No transactions',
                              style: TextStyle(fontSize: 20),
                            ))
                          : ListView.separated(
                              itemCount: widget.userToDriverTransactions.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              itemBuilder: (context, index) {
                                return DebitCard(
                                  amountTransferred:
                                      reversedUserToDriverTransactions[index]
                                          ['amountTransferred'],
                                  dateTransferred:
                                      reversedUserToDriverTransactions[index]
                                          ['datePaid'],
                                );
                              })
                    ],
                  ),
                ),
              ),
              // Money Received History Tab
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(top: 40),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      // TODO: Implement the UI for Money Received History tab
                      // Replace the following placeholder widget
                      Center(
                        child: Text(
                          'Money Received History',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
