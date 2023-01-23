import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

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
      length: 3,
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
                    text: 'Active Now',
                  ),
                  Tab(
                    text: 'Completed',
                  ),
                  Tab(
                    text: 'Cancelled',
                  ),
                ],
              ),
            ),
            const Expanded(
                child: TabBarView(
              children: [ActivePage(), CompletedPage(), CancelledPage()],
            ))
          ],
        ),
      )),
    );
  }
}

class ActivePage extends StatelessWidget {
  const ActivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
            "assets/images/clipjotter.png"),
        const Text(
          'You have no Active Bookings',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )
      ],
    ));
  }
}

class CompletedPage extends StatelessWidget {
  const CompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
                "assets/images/clipjotter.png"),
            const Text(
              'You have no Completed Bookings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ));
  }
}

class CancelledPage extends StatelessWidget {
  const CancelledPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
                "assets/images/clipjotter.png"),
            const Text(
              'You have no Cancelled Bookings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ));
  }
}
