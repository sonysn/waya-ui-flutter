import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:waya/api/actions.dart';
import '../../../colorscheme.dart';

class BookingPage extends StatefulWidget {
  final dynamic data;
  const BookingPage({Key? key, this.data}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  dynamic ridesArray = [];

  Color getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.grey;
      case 'Cancelled':
        return Colors.red;
      case 'Completed':
        return Colors.orangeAccent;
      default:
        return Colors
            .transparent; // Default color if status doesn't match any case
    }
  }

  Future getRides() async {
    final response = await getRideHistory(riderID: widget.data.id);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        ridesArray = data.reversed.toList();
      });
      //print(ridesArray);
    }
  }

  Future _refreshItems() async {
    await getRides();
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    getRides();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.orangeAccent,
      backgroundColor: customPurple,
      onRefresh: _refreshItems,
      child: DefaultTabController(
        length: 1,
        child: Scaffold(
            body: Container(
          padding: const EdgeInsets.only(top: 40),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "My Bookings",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 45,
                decoration: const BoxDecoration(
                    //color: Colors.grey[300],
                    // border: Border(
                    //   bottom: BorderSide(width: 3.0, color: Colors.grey)
                    // ),
                    ),
                child: const TabBar(
                  indicator: BoxDecoration(
                    //color: Colors.yellow[100],
                    border: Border(
                        bottom: BorderSide(width: 3.0, color: customPurple)),
                  ),
                  labelColor: customPurple,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(
                      text: 'Ride History',
                    ),
                  ],
                ),
              ),
              ridesArray == []
                  ? Expanded(
                      child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/cp.png"),
                                const SizedBox(height: 20),
                                const Text(
                                  'You have no Completed Bookings',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ))
                  : Expanded(
                      child: ListView.builder(
                        itemCount: ridesArray.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> rideData = ridesArray[index];

                          // Extract the data from the rideData map
                          String requestDate = rideData['REQUEST_DATE'];
                          String pickupLocation = rideData['PICKUP_LOCATION'];
                          String dropoffLocation = rideData['DROPOFF_LOCATION'];
                          int fare = rideData['FARE'];
                          String status = rideData['STATUS'];

                          // Format the date
                          DateTime date = DateTime.parse(requestDate);

                          String formattedDate =
                              DateFormat('MMM dd, yyyy').format(date);

                          return ListTile(
                            title: const Text(
                              'Ride Details',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Request Date: $formattedDate'),
                                Text('Pickup Location: $pickupLocation'),
                                Text('Dropoff Location: $dropoffLocation'),
                                Text('Fare: $fare'),
                                Text(
                                  'Status: $status',
                                  style: TextStyle(
                                    // Call a function to get the color based on the status
                                    color: getStatusColor(status),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
            ],
          ),
        )),
      ),
    );
  }
}

class CompletedPage extends StatelessWidget {
  const CompletedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Replace this with the actual booking data
    final List<dynamic> bookings = [];

    if (bookings.isEmpty) {
      return SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/cp.png"),
              const SizedBox(height: 20),
              const Text(
                'You have no Completed Bookings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];

        return Card(
          // TODO: Customize card styling as per your design
          child: ListTile(
            // TODO: Display booking information
            title: Text('Booking ID: ${booking.id}'),
            subtitle: Text('Date: ${booking.date}'),
            trailing: Text('Status: ${booking.status}'),
          ),
        );
      },
    );
  }
}
