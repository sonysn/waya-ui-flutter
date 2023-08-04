import 'package:flutter/material.dart';
import 'package:qunot/screens/passwordchange.dart';
import 'package:qunot/colorscheme.dart';
import 'package:qunot/constants/design_constants.dart';

class PasswordSettings extends StatefulWidget {
  final int userId;
  final String authToken;
  const PasswordSettings(
      {Key? key, required this.userId, required this.authToken})
      : super(key: key);

  @override
  State<PasswordSettings> createState() => _PasswordSettingsState();
}

class _PasswordSettingsState extends State<PasswordSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 25,
                color: kPrimaryColor,
              ),
            ),
            const Text(
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
                  return ChangePasswordPage(
                      id: widget.userId, authToken: widget.authToken);
                }));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: customPurple,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                      bottom: Radius.circular(20),
                    ),
                  )),
              child: const SizedBox(
                width: 260,
                height: 50,
                child: Center(
                    child: Text(
                  'Change Password',
                  style: TextStyle(color: kTextColor),
                )),
              )),
        ),
      ]),
    );
  }
}
