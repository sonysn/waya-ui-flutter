import 'package:flutter/material.dart';
import 'package:qunot/colorscheme.dart';
import 'package:qunot/screens/profile/profilepage.dart';

class EditProfile extends StatefulWidget {
  final dynamic data;
  const EditProfile({Key? key, required this.data}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  //Todo Text editing controller holds the user input for program execution, the names are self explanatory of what they do or hold
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      email = TextEditingController(text: widget.data.email);
      firstname = TextEditingController(text: widget.data.firstName);
      lastname = TextEditingController(text: widget.data.lastName);
      phoneNumber = TextEditingController(text: widget.data.phoneNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        const SizedBox(
          height: 20,
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
                color: Colors.black,
              ),
            ),
            const Text(
              'Edit Profile',
              style: TextStyle(fontSize: 30),
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
                        cursorColor: customPurple,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            hintText: 'Enter your phone number',
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
                            hintText: 'Enter your email',
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
                        return const ProfilePage();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: customPurple,
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
                        'Update',
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
