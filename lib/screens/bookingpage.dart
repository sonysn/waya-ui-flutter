import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              labelColor: Colors.yellow,
              indicatorColor: Colors.amberAccent,
              tabs: [
                Tab(text: 'Active'),
                Tab(text: 'Completed'),
                Tab(text: 'Cancelled'),
              ],
            ),
            title: Text('My Bookings', style:TextStyle(color: Colors.black),  ) ,
            backgroundColor: Colors.white,
          ),
          body: TabBarView(
            children: [
              ActivePage(),
              CompletedPage(),
              CancelledPage(),
            ],
          ),
        ),

    );
  }
}

class ActivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Active'),
    );
  }
}

class CompletedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Completed'),
    );
  }
}

class CancelledPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Cancelled'),
    );
  }
}
