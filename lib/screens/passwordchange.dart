import 'package:flutter/material.dart';
import '../../../colorscheme.dart';
class ChangePasswordPage extends StatefulWidget {
  @override
  ChangePasswordPageState createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customPurple,
        title: Text('Change Password'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32.0),
              Text(
                'Change Your Password',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 32.0),
              TextFormField(
                controller: _currentPasswordController,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  labelStyle: TextStyle(
                    color: customPurple,
                  ),
                  prefixIcon: Icon(Icons.lock, color: Colors.orangeAccent),
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
                    _currentPasswordController.text = '';
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  labelStyle: TextStyle(
                    color: customPurple,
                  ),
                  prefixIcon: Icon(Icons.lock, color: Colors.orangeAccent),
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
                    _newPasswordController.text = '';
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(
                    color: customPurple,
                  ),
                  prefixIcon: Icon(Icons.lock, color: Colors.orangeAccent),
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
                    // TODO: Perform password change logic
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
