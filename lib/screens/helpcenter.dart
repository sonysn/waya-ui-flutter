import 'package:flutter/material.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 1, vsync: this);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 25,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Help Center',
                  style: TextStyle(fontSize: 30),
                ),
              ],
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
                    text: 'ContactUs',
                  ),

                ],
              ),
            ),
            const Expanded(
                child: TabBarView(
              children: [ContactUs()],
            ))
          ],
        ),
      )),
    );
  }
}

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
      Center(
      child: Container(
        height: 50,
        //width: 350,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: SizedBox(
          height: 50,
          width: 350,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.invert_colors,
                size: 15.0,
                color: Colors.yellow,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Website',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ),

      ),


      )

        ],

      ));
  }
}

//backgroundColor: Colors.orange,

