import 'package:flutter/material.dart';

import '../colorscheme.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  static String routeName = "/EditProfilePage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              //todo add details later
              children: const [
                TextField(
                  //controller: phoneNumber,
                  readOnly: true,
                  cursorColor: customPurple,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'First name',
                      contentPadding: EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.yellow),
                      )),
                ),

                SizedBox(height: 20),
                TextField(
                  //controller: phoneNumber,
                  readOnly: true,
                  cursorColor: customPurple,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Last name',
                      contentPadding: EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.yellow),
                      )),
                ),
                SizedBox(height: 20),
                TextField(
                  //controller: phoneNumber,
                  readOnly: true,
                  cursorColor: customPurple,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Phone Number',
                      contentPadding: EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.yellow),
                      )),
                ),
                SizedBox(height: 20),
                TextField(
                  //controller: phoneNumber,
                  readOnly: true,
                  cursorColor: customPurple,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      contentPadding: EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.yellow),
                      )),
                ),
                SizedBox(height: 20),
                TextField(
                  //controller: phoneNumber,
                  readOnly: true,
                  cursorColor: customPurple,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      contentPadding: EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.yellow),
                      )),
                ),
                SizedBox(height: 20),
                TextField(
                  //controller: phoneNumber,
                  readOnly: true,
                  cursorColor: customPurple,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Address',
                      contentPadding: EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.yellow),
                      )),
                ),
                SizedBox(height: 20),
                TextField(
                  //controller: phoneNumber,
                  readOnly: true,
                  cursorColor: customPurple,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'dob',
                      contentPadding: EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.yellow),
                      )),
                ),
                SizedBox(height: 20),



              ],
            ),
          )
        ],
      ),
    );
  }
}
