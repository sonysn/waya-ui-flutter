import 'package:flutter/material.dart';
import 'package:waya/colorscheme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10),
            margin: const EdgeInsets.symmetric(horizontal: 7),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: const BoxDecoration(
                    color: customPurple,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                  ),
                  child: const Icon(Icons.account_circle),
                ),
                Text('Profile')
              ],
            ),
          )
        ],
      ),
    );
  }
}
