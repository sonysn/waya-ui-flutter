import 'package:flutter/material.dart';
import 'package:waya/api/auth.dart';
import 'package:waya/colorscheme.dart';
import '../constants/design_constants.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailOrPhoneTextController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    emailOrPhoneTextController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _resetPassword() async {
    setState(() {
      _isLoading = true;
    });
    // You can use the emailOrPhoneTextController.text to retrieve the entered email
    // and implement the necessary logic for resetting the password.
    // Once the password is reset, you can show a success message or navigate
    // to a different screen.
    // Example:
    // Your password reset logic here...
    final response = await forgotPassword(
        emailOrphoneNumber: emailOrPhoneTextController.text);
    //
    switch (response.statusCode) {
      case 200:
        _showSnackBar('Password reset email sent!');
        setState(() {
          _isLoading = false;
        });
        break;
      case 404:
        _showSnackBar('User not found!');
        setState(() {
          _isLoading = false;
        });
        break;
      default:
        _showSnackBar('Something went wrong!');
        setState(() {
          _isLoading = false;
        });
    }

    // // Simulating a delay for demonstration purposes
    // Future.delayed(const Duration(seconds: 2), () {
    //   setState(() {
    //     _isLoading = false;
    //   });
    //   _showSnackBar('Password reset email sent!');
    //   // Navigate to a different screen if needed
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: customPurple,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Forgot Your Password?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: customPurple,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Enter your email address below to reset your password.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: emailOrPhoneTextController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email Address or Phone Number',
                      contentPadding: const EdgeInsets.all(15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (emailOrPhoneTextController.text.isNotEmpty) {
                        _resetPassword();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: customPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
