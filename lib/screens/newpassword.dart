import 'package:flutter/material.dart';
import 'package:waya/colorscheme.dart';
import '../constants/design_constants.dart';
import 'package:waya/screens/loginpage.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  State<NewPasswordPage> createState() => NewPasswordPageState();
}

class NewPasswordPageState extends State<NewPasswordPage> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void _resetPassword() {
    // Implement the logic to reset the password
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    // Check if the passwords match and perform the password reset action
    if (newPassword == confirmPassword) {
      // Perform the password reset action
      // TODO: Add your password reset logic here
      print('Password Reset Successful');
    } else {
      // Passwords do not match, show an error message
      print('Passwords do not match');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Password'),
        backgroundColor: customPurple, // Set the app bar background color to custom purple
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),Text(
                'Set New Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: customPurple,
                ),
              ),
              const SizedBox(height: 20),
              Divider(
                thickness: 2,
                color: Colors.black,
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 40),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: customPurple, // Set the border color to custom purple when focused
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: customPurple, // Set the border color to custom purple when focused
                      width: 2,
                    ),
                  ),
                ),
              ),Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Navigate to the forgot password page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return LoginPage();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 3),
              ElevatedButton(
                onPressed: _resetPassword,
                style: ElevatedButton.styleFrom(
                  primary: customPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Set New Password',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
