import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qunot/screens/editprofile.dart';
import 'package:qunot/screens/helpcenter.dart';
import 'package:qunot/screens/passwordsettings.dart';
import 'package:qunot/screens/privacypolicy.dart';
import 'package:qunot/api/auth.dart';
import 'package:qunot/screens/welcomepage.dart';
import 'package:qunot/screens/profile/components/profile_menu.dart';
import 'package:qunot/screens/profile/components/profile_pic.dart';

class Body extends StatefulWidget {
  final dynamic data;
  const Body({Key? key, required this.data}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  dynamic data;

  @override
  void initState() {
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
          ProfilePic(
            userID: widget.data.id,
            userToken: widget.data.authToken,
            profilePhotoLink: widget.data.profilePhoto,
          ),
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
              return PasswordSettings(
                  userId: widget.data.id, authToken: widget.data.authToken);
            })),
          ),
          ProfileMenu(
            text: "Privacy Policy",
            icon: "assets/icons/pp.svg",
            press: () => Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return const PrivacyPolicyPage();
            })),
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/hc.svg",
            press: () => Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return const HelpCenterPage();
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
                  final response = await logOut(
                      id: widget.data.id, authBearer: widget.data.authToken);
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
