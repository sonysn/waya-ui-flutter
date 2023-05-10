import 'package:flutter/material.dart';
import 'package:waya/colorscheme.dart';
import 'package:waya/screens/bottom_nav.dart';
import 'package:waya/screens/homepage.dart';
import '../constants/design_constants.dart';

class SignUp extends StatefulWidget {
  final dynamic phoneNumber;
  const SignUp({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //Todo Text editing controller holds the user input for program execution, the names are self explanatory of what they do or hold
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController homeAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        const SizedBox(
          height: 15,
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
              'Register',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                  color: Colors.black),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(top: 10),
          margin: const EdgeInsets.symmetric(horizontal: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 12, bottom: 10),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'First name',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      //TextField for name
                      TextField(
                        controller: firstname,
                        cursorColor: customPurple,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            hintText: 'Enter your First Name',
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
                              borderSide: BorderSide(color: Colors.yellow),
                            )),
                      ),
                    ],
                  )),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'Last Name',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      //TextField for name
                      TextField(
                        controller: lastname,
                        cursorColor: customPurple,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            hintText: 'Enter your Last Name',
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
                              borderSide: BorderSide(color: Colors.yellow),
                            )),
                      ),
                    ],
                  )),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'Password',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
              ),
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
                            hintText: 'Enter your password',
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
                              borderSide: BorderSide(color: Colors.yellow),
                            )),
                      ),
                    ],
                  )),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'Phone Number',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      //TextField for name
                      TextField(
                        controller: phoneNumber,
                        readOnly: true,
                        cursorColor: customPurple,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: widget.phoneNumber,
                            contentPadding: const EdgeInsets.all(15),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15)),
                              borderSide:
                              BorderSide(color: Colors.black),
                            ),
                            filled: true,
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15)),
                              borderSide:
                              BorderSide(color: Colors.yellow),
                            )),
                      ),
                    ],
                  )),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'Email',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
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
                            hintText: 'Enter your Email',
                            contentPadding: EdgeInsets.all(15),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15)),
                              borderSide:
                              BorderSide(color: Colors.black),
                            ),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15)),
                              borderSide:
                              BorderSide(color: Colors.yellow),
                            )),
                      ),
                    ],
                  )),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'Address',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      //TextField for name
                      TextField(
                        controller: homeAddress,
                        cursorColor: customPurple,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            hintText: 'Enter your Address',
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
                              borderSide: BorderSide(color: Colors.yellow),
                            )),
                      ),
                    ],
                  )),
              const SizedBox(height: 10),
              //sign up button
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return BottomNavPage();
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
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      )),
                    )),
              ),
              const SizedBox(height: 10)
            ],
          ),
        )
      ],
    ));
  }
}
