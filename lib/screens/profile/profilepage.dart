import 'package:flutter/material.dart';

import 'components/body.dart';


class ProfilePage extends StatefulWidget {
  final dynamic data;
  const ProfilePage({Key? key, this.data}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  dynamic data;

  static String routeName = "/profile";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Body(
        data: data
      ),

    );
  }
}
