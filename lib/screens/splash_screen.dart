import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waya/screens/onboarding.dart';
import 'package:waya/api/auth.dart';
import 'package:waya/screens/bottom_nav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    // get shared preferences to retrieve email/phone and password
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? emailOrPhone = prefs.getString('emailOrPhone');
    String? password = prefs.getString('password');
    String? deviceID = prefs.getString('deviceID');

    // check if email/phone and password are not null
    if (emailOrPhone != null && password != null) {
      try {
        // if email/phone and password exist, sign in and navigate to BottomNavPage after a 3 second delay
        final response = await signIn(emailOrPhone, password, deviceID);
        Timer(const Duration(seconds: 2), () {
          if (response.data != null) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 2000),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    FadeTransition(
                  opacity: animation,
                  child: BottomNavPage(data: response.data),
                ),
              ),
            );
          }
        });
      } on SocketException catch (e) {
        print(e);
        Timer(const Duration(seconds: 3), () {
          _showSnackBar(
              'Connection failed. Please check your internet connection.');
          _checkLoginStatus();
        });
      } on TimeoutException catch (e) {
        print(e);
        Timer(const Duration(seconds: 3), () {
          _showSnackBar('Request timed out. Please try again later.');
        });
      } catch (e) {
        print(e);
      }
    } else {
      // if email/phone and password do not exist, navigate to WelcomePage after a 3 second delay
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                const Onboarding(),
            transitionsBuilder: (context, animation1, animation2, child) {
              return FadeTransition(
                opacity: animation1,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 2000),
          ),
        );
      });
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Image(
        image: AssetImage("assets/icons/logo.png"),
        width: 200.0,
        height: 200.0,
      )),
    );
  }
}
