import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:waya/api/auth.dart';
import 'package:waya/colorscheme.dart';
import 'package:waya/screens/bottom_nav.dart';
import 'package:waya/screens/homepage.dart';
import 'package:waya/screens/loginpage.dart';
import '../constants/design_constants.dart';

class SignUp extends StatefulWidget {
  final dynamic phoneNumber;
  const SignUp({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  dynamic _serverResponse() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await signUp(
          firstname: firstname.text,
          lastname: lastname.text,
          phoneNumber: widget.phoneNumber,
          password: password.text,
          email: email.text,
          homeAddress: homeAddress.text,
          dob: dateController.text);
      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        _nav();
      } else {
        setState(() {
          _isLoading = false;
        });
        var message = response.body;
        _showSnackBar(message['message']);
      }
    } on SocketException catch (e) {
      debugPrint(e.toString());
      _showSnackBar(
          'Connection failed. Please check your internet connection.');
    } on TimeoutException catch (e) {
      debugPrint(e.toString());
      _showSnackBar('Request timed out. Please try again later.');
    } catch (e) {
      print(e);
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _nav() {
    _showSnackBar('Login to your new account');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  //PICK DATE
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  //Todo Text editing controller holds the user input for program execution, the names are self explanatory of what they do or hold
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController homeAddress = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    firstname.dispose();
    lastname.dispose();
    phoneNumber.dispose();
    password.dispose();
    email.dispose();
    homeAddress.dispose();
    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const Center(
                    //     child: Image(
                    //   image: AssetImage("assets/icons/logo.png"),
                    //   width: 200.0,
                    //   height: 200.0,
                    // )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'We\'re Setting Up Your Profile...',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    LoadingAnimationWidget.waveDots(
                        color: Colors.black, size: 70)
                  ],
                ),
              )
            : ListView(
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
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Text(
                            'DOB',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.all(12),
                            child: TextField(
                              cursorColor: Colors.black,
                              controller: dateController,
                              onTap: () {
                                _selectDate(context);
                              },
                              decoration: InputDecoration(
                                hintText: 'Select Date',
                                suffixIcon: const Icon(
                                  Icons.calendar_today,
                                  color: Colors.black,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.yellow),
                                ),
                              ),
                            )),
                        const SizedBox(height: 10),
                        //sign up button
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                // Navigator.push(context, MaterialPageRoute(
                                //     builder: (BuildContext context) {
                                //   return BottomNavPage();
                                // }));
                                if (firstname.text == "" ||
                                    lastname.text == "" ||
                                    password.text == "" ||
                                    email.text == "") {
                                  _showSnackBar("Input your details");
                                }
                                if (firstname.text != "" &&
                                    lastname.text != "" &&
                                    password.text != "" &&
                                    widget.phoneNumber != "" &&
                                    email.text != "") {
                                  _serverResponse();
                                }
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
