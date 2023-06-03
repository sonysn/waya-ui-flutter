import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waya/screens/editprofile.dart';
import 'package:waya/screens/helpcenter.dart';
import 'package:waya/screens/addresssettings.dart';
import 'package:waya/screens/passwordsettings.dart';

import '../../../api/auth.dart';
import '../../welcomepage.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  dynamic data;
  Body({Key? key, this.data}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  dynamic data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          const ProfilePic(),
          const SizedBox(height: 10),
          ProfileMenu(
              text: "Edit Profile",
              icon: "assets/icons/User Icon.svg",
              press: () => Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return EditProfile(data: data);
                  }))),

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
            press: () {},
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
            press: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();

              //define functions
              void nav() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomePage()),
                );
              }

              void showSnackBar(String message) {
                final snackBar = SnackBar(
                  content: Text(message),
                  duration: const Duration(seconds: 3),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

              logout() async {
                try {
                  final response = await logOut(widget.data.id);
                  if (response == 'logout success') {
                    // Remove the content of emailOrPhone and password
                    prefs.remove('emailOrPhone');
                    prefs.remove('password');
                    prefs.remove('deviceID');
                    nav();
                  }
                } on SocketException catch (e) {
                  debugPrint(e.toString());
                  showSnackBar(
                      'Logout failed. Please check your internet connection.');
                } on TimeoutException catch (e) {
                  debugPrint(e.toString());
                  showSnackBar('Request timed out. Please try again later.');
                } catch (e) {
                  debugPrint(e.toString());
                }
              }

              logout();
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
