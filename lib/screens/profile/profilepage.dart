import 'package:flutter/material.dart';

import 'components/body.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Body(),

    );
  }
}
