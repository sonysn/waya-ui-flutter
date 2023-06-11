import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waya/colorscheme.dart';
import 'package:waya/screens/homepage.dart';
import 'package:waya/screens/walletpage.dart';
import 'package:waya/screens/profile/profilepage.dart';
import 'package:waya/screens/bookingpage.dart';

class BottomNavPage extends StatefulWidget {
  final dynamic data;
  const BottomNavPage({Key? key, required this.data}) : super(key: key);

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _currentIndex = 0;
  dynamic data;
  late final List<Widget> _childrenPages = <Widget>[
    HomePage(data: data),
    BookingPage(data: data),
    WalletPage(data: data),
    ProfilePage(data: data)
  ];

  void onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _childrenPages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: customPurple,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        //type allows you have more than 1 item in bottom navigator
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bookmark), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Wallet'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled), label: 'Profile'),
        ],
      ),
    );
  }
}
