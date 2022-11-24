import 'package:flutter/material.dart';
import 'package:waya/colorscheme.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(
                color: customPurple
              ),
              child: Text("Drawer Header"),
            ),
            ListTile(
              title: Text("Profile"),
            ),
            ListTile(
              title: Text("Settings"),
            ),
            ListTile(
              title: Text("Trips"),
            )
          ],
        ),
      ),
    );
  }
}
