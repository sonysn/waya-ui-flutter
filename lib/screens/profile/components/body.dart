import 'package:flutter/material.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';
import 'package:waya/screens/editprofilepage.dart';
class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);


  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? profileImageUrl;
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
            press: () => {GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const EditProfilePage();
                    }));
              },
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        //this checks if profileImageUrl is null and returns blank profile picture from this link todo set this to asset image
                        image: profileImageUrl != null
                            ? NetworkImage(profileImageUrl!)
                            : const NetworkImage(
                            'assets/images/h.png'))),
              ),
            )},
          ),
          ProfileMenu(
            text: "Address",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Security",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Privacy Policy",
            icon: "assets/icons/Log out.svg",
            press: () {
            },
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Log out.svg",
            press: () {},
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
