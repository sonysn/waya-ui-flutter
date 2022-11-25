import 'package:flutter/material.dart';
import 'package:waya/colorscheme.dart';
import 'package:waya/screens/profilepage.dart';

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
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: customPurple
              ),
              child: Text("Drawer Header"),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const ProfilePage();
                    }));
              },
              child: const ListTile(
                title: Text("Profile"),
              ),
            ),
            const Divider(),
            const ListTile(
              title: Text("Settings"),
            ),
            const Divider(),
            const ListTile(
              title: Text("Trips"),
            )
          ],
        ),
      ),
    );
  }
}
