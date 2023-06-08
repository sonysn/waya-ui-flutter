import 'package:flutter/material.dart';
import 'package:waya/api/auth.dart';
import '../../../colorscheme.dart';

class ChangePasswordPage extends StatefulWidget {
  final int id;
  const ChangePasswordPage({super.key, required this.id});

  @override
  ChangePasswordPageState createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future changePasswordinPage() async {
    final response = await changePassword(
        id: widget.id,
        newPassword: _newPasswordController.text,
        oldPassword: _currentPasswordController.text);

    switch (response.statusCode) {
      case 200:
        _showSnackBar('Password changed successfully!');
        break;
      case 401:
        _showSnackBar('Incorrect current password!');
        break;
      case 500:
        _showSnackBar('Something went wrong!');
        break;
      default:
        _showSnackBar('Something went wrong!');
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customPurple,
        title: const Text('Change Password'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32.0),
              const Text(
                'Change Your Password',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32.0),
              TextFormField(
                controller: _currentPasswordController,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  labelStyle: const TextStyle(
                    color: customPurple,
                  ),
                  prefixIcon:
                      const Icon(Icons.lock, color: Colors.orangeAccent),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: true,
                cursorColor: Colors.orangeAccent,
                style: const TextStyle(color: Colors.orangeAccent),
                onTap: () {
                  setState(() {
                    _currentPasswordController.text = '';
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  labelStyle: const TextStyle(
                    color: customPurple,
                  ),
                  prefixIcon:
                      const Icon(Icons.lock, color: Colors.orangeAccent),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: true,
                cursorColor: Colors.orangeAccent,
                style: const TextStyle(color: Colors.orangeAccent),
                onTap: () {
                  setState(() {
                    _newPasswordController.text = '';
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: const TextStyle(
                    color: customPurple,
                  ),
                  prefixIcon:
                      const Icon(Icons.lock, color: Colors.orangeAccent),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: true,
                cursorColor: Colors.orangeAccent,
                style: TextStyle(color: Colors.orangeAccent),
                onTap: () {
                  setState(() {
                    _confirmPasswordController.text = '';
                  });
                },
              ),
              SizedBox(height: 32.0),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_newPasswordController.text !=
                        _confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Passwords do not match'),
                      ));
                    } else {
                      changePasswordinPage();
                      setState(() {
                        _confirmPasswordController.clear();
                        _newPasswordController.clear();
                        _currentPasswordController.clear();
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: customPurple,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Change Password',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
