import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qunot/screens/bottom_nav.dart';
import 'package:qunot/screens/forgotpassword.dart';
import 'package:qunot/api/auth.dart';
import 'package:qunot/colorscheme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  dynamic _serverResponse() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await signIn(
          emailOrPhoneTextController.text, passwordTextController.text, token);
      if (response.statusCode == 200) {
        setState(() {
          _futureData = response.data;
        });
        if (_futureData != null) {
          setState(() {
            _isLoading = false;
          });
          _nav();
        }
      } else {
        var msg = response.body;
        //print(msg['message']);
        _showSnackBar(msg['message']);
        setState(() {
          _isLoading = false;
        });
      }
    } on SocketException catch (e) {
      print(e);
      _showSnackBar(
          'Connection failed. Please check your internet connection.');
    } on TimeoutException catch (e) {
      print(e);
      _showSnackBar('Request timed out. Please try again later.');
    } catch (e) {
      print(e);
    } finally {}
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _nav() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return BottomNavPage(
        data: _futureData,
      );
    }));
  }

  TextEditingController emailOrPhoneTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  String? token;
  bool val = false;
  bool _passwordVisible = false;
  bool _rememberMe = true;
  bool _isLoading = false;
  dynamic _futureData;

  @override
  void initState() {
    super.initState();
    _loadCredentials();
    FirebaseMessaging.instance.getToken().then((devToken) {
      setState(() {
        token = devToken;
      });
    });
  }

  @override
  void dispose() {
    emailOrPhoneTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  void _loadCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? emailOrPhone = prefs.getString('emailOrPhone');
    String? password = prefs.getString('password');
    if (emailOrPhone != null && password != null) {
      emailOrPhoneTextController.text = emailOrPhone;
      passwordTextController.text = password;
      setState(() {
        _rememberMe = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: _isLoading
            ? Center(
                child: LoadingAnimationWidget.waveDots(
                color: Colors.black,
                size: 70,
              ))
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),
                      const Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 27,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: emailOrPhoneTextController,
                        cursorColor: customPurple,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          // Disallow whitespace
                        ],
                        decoration: InputDecoration(
                          hintText: 'Email or Phone Number',
                          contentPadding: const EdgeInsets.all(15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.orangeAccent),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.account_circle_outlined,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordTextController,
                        cursorColor: customPurple,
                        keyboardType: TextInputType.text,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          contentPadding: const EdgeInsets.all(15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.orangeAccent),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.black87,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Navigate to the forgot password page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const ForgotPasswordPage();
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          if (emailOrPhoneTextController.text.isNotEmpty &&
                              passwordTextController.text.isNotEmpty) {
                            _serverResponse();
                            if (_rememberMe) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString('emailOrPhone',
                                  emailOrPhoneTextController.text);
                              await prefs.setString(
                                  'password', passwordTextController.text);
                              await prefs.setString('deviceID', token!);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: customPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
