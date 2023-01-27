import 'package:flutter/material.dart';
import 'package:waya/screens/profile/profilepage.dart';
import '../../../constants.dart';
class PasswordSettings extends StatefulWidget {
  const PasswordSettings({Key? key}) : super(key: key);

  @override
  State<PasswordSettings> createState() =>
      _PasswordSettingsState();
}

class _PasswordSettingsState extends State<PasswordSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(

            children: [   const SizedBox(
              height: 20,
            ),
              Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 25,
                    color: kPrimaryColor,
                  ),
                ),
                Text(
                    'Security',
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),

        const SizedBox(
          height: 20,
        ),
        Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const ProfilePage();
                    }));
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                      bottom: Radius.circular(20),
                    ),
                  )),
              child: const SizedBox(
                width: 260,
                height: 50,
                child: Center(child: Text('Change Pin', style: TextStyle(

                    color: kPrimaryColor),)
                ),
              )),
        ), const SizedBox(
                height: 20,
              ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const ProfilePage();
                        }));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.yellow,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                          bottom: Radius.circular(20),
                        ),
                      )),
                  child: const SizedBox(
                    width: 260,
                    height: 50,
                    child: Center(child: Text('Change Password', style: TextStyle(

                        color: kPrimaryColor),)
                    ),
                  )),
            ),
      ]),
    );
  }
}
