import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:waya/api/actions.dart';
import 'package:waya/colorscheme.dart';
import 'package:waya/models/requested_rides.dart';

class BookingPage extends StatefulWidget {
  final dynamic data;

  const BookingPage({Key? key, this.data}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  List<dynamic> ridesArray = [];

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

  Future<void> getRides() async {
    final response = await getRideHistory(riderID: widget.data.id);

    // if (response.statusCode == 200) {
    //   final data = json.decode(response.body);
    //   setState(() {
    //     ridesArray = data.reversed.toList();
    //   });
    // }
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      final reversedBookingList = data.reversed.toList();
      final bookingList = reversedBookingList.asMap().entries.map((entry) {
        //final index = entry.key;
        final booking = entry.value;
        return RequestedRides.fromJson(booking);
      }).toList();
      setState(() {
        ridesArray = bookingList.toList();
      });
    }
  }

  Future<void> _refreshItems() async {
    await getRides();
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    getRides();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
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
            padding: const EdgeInsets.only(top: 15),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    "My Bookings",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 45,
                    decoration: const BoxDecoration(),
                    child: const TabBar(
                      indicator: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 3.0, color: customPurple),
                        ),
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
                  const SizedBox(height: 10),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ridesArray.isEmpty
                            ? SingleChildScrollView(
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
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: ridesArray.length,
                                itemBuilder: (context, index) {
                                  // Map<String, dynamic> rideData =
                                  //     ridesArray[index];

                                  // Extract the data from the rideData map
                                  String requestDate =
                                      ridesArray[index].requestDate;
                                  String pickupLocation =
                                      ridesArray[index].pickupAddress;
                                  String dropoffLocation =
                                      ridesArray[index].dropOffAddress;
                                  int fare = ridesArray[index].fare;
                                  String status = ridesArray[index].status;

                                  // Format the date
                                  DateTime date = DateTime.parse(requestDate);
                                  String formattedDate =
                                      DateFormat('MMM dd, yyyy').format(date);

                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Ride Details',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(height: 3),
                                        ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text(
                                            'Request Date',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            formattedDate,
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ),
                                        ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text(
                                            'Pickup Location',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            pickupLocation,
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ),
                                        ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text(
                                            'Dropoff Location',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            dropoffLocation,
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ),
                                        ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text(
                                            'Fare',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            '₦$fare',
                                            style: const TextStyle(
                                                color: Colors.green),
                                          ),
                                        ),
                                        ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text(
                                            'Status',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            status,
                                            style: TextStyle(
                                              color: getStatusColor(status),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CompletedPage extends StatelessWidget {
  const CompletedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: ListTile(
            title: Text('Booking ID: ${booking.id}'),
            subtitle: Text('Date: ${booking.date}'),
            trailing: Text('Status: ${booking.status}'),
          ),
        );
      },
    );
  }
}
