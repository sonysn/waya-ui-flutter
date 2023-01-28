import 'package:flutter/material.dart';
import 'package:waya/screens/editprofile.dart';
import 'package:waya/screens/helpcenter.dart';
import 'package:waya/screens/addresssettings.dart';
import 'package:waya/screens/passwordsettings.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';
class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);


  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),


          ProfileMenu(
            text: "Edit Profile",
            icon: "assets/icons/User Icon.svg",
            press: () => Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return const EditProfile();
                }))

          ),
          ProfileMenu(
            text: "Address",
            icon: "assets/icons/ad.svg",
            press: () => Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
                return const AddressSettings();
              })),
          ),
          //ProfileMenu(
          //  text: "Notifications",
            //icon: "assets/icons/Settings.svg",
           // press: () => Navigator.push(context,

        //MaterialPageRoute(builder: (BuildContext context) {
         //return const CardScreen();
               // })),
       //   ),
          ProfileMenu(
            text: "Security",
            icon: "assets/icons/password.svg",
            press: () => Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
                return const PasswordSettings();
              })),
          ),
          ProfileMenu(
            text: "Privacy Policy",
            icon: "assets/icons/pp.svg",
            press: () {
            },
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/hc.svg",
            press: () => Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return const HelpCenter();
                })),
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {},
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
