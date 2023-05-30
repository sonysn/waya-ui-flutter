import 'package:flutter/material.dart';
import 'package:waya/colorscheme.dart';
import '../constants/design_constants.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailTextController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    emailTextController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _resetPassword() {
    setState(() {
      _isLoading = true;
    });
    // TODO: Implement your password reset logic here
    // You can use the emailTextController.text to retrieve the entered email
    // and implement the necessary logic for resetting the password.
    // Once the password is reset, you can show a success message or navigate
    // to a different screen.
    // Example:
    // Your password reset logic here...

    // Simulating a delay for demonstration purposes
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar('Password reset email sent!');
      // Navigate to a different screen if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        backgroundColor: customPurple,
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Forgot Your Password?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: customPurple,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Enter your email address below to reset your password.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            TextField(
              controller: emailTextController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email Address',
                contentPadding: EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetPassword,
              style: ElevatedButton.styleFrom(
                primary: customPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
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
