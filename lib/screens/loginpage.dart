import 'package:flutter/material.dart';
import 'package:waya/screens/bottom_nav.dart';
import '../colorscheme.dart';
import 'homepage.dart';
import '../constants/design_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool val = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              margin: const EdgeInsets.symmetric(horizontal: 7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 12, bottom: 10),
                    child: Text(
                      'Login to your account',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 27,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          //TextField for name
                          TextField(
                            controller: email,
                            cursorColor: customPurple,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                hintText: 'Email',
                                contentPadding: EdgeInsets.all(15),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide:
                                      BorderSide(color: Colors.yellow),
                                )),
                          ),
                        ],
                      )),
                  Container(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          //TextField for name
                          TextField(
                            controller: password,
                            cursorColor: customPurple,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                hintText: 'Password',
                                contentPadding: EdgeInsets.all(15),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide:
                                      BorderSide(color: Colors.yellow),
                                )),
                          ),
                        ],
                      )),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const BottomNavPage();
                          }));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: customPurple,
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
                            'Login',
                            style: TextStyle(color: kTextColor),
                          )),
                        )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
