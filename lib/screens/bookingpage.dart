import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  final dynamic data;
  const BookingPage({Key? key, this.data}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
              child: TabBar(
                indicator: const BoxDecoration(
                  //color: Colors.yellow[100],
                  border: Border(
                      bottom: BorderSide(width: 3.0, color: Colors.yellow)),
                ),
                labelColor: Colors.yellow[600],
                unselectedLabelColor: Colors.black,
                tabs: const [
                  Tab(
                    text: 'Ride History',
                  ),

                ],
              ),
            ),
            const Expanded(
                child: TabBarView(
              children: [ CompletedPage()],
            ))
          ],
        ),
      )),
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
