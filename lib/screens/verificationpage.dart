import 'package:flutter/material.dart';
import 'package:waya/colorscheme.dart';
import 'package:waya/screens/signup.dart';
import '../../../constants.dart';
class VerificationPage extends StatefulWidget {
  String phoneNumber;

  VerificationPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  TextEditingController verificationCode = TextEditingController();
  String inputText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [const SizedBox(
          height: 20,
        ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 25,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Center(
              child: Column(
                children: [
                  //for the circle
                  Container(
                      padding: const EdgeInsets.all(30),
                      decoration: const BoxDecoration(
                          color: customPurple,
                          borderRadius: BorderRadius.all(Radius.circular(150))),
                      child: const Icon(
                        Icons.mail_outline,
                        size: 150,
                        color: Colors.black,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Verification Code",
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Type in the verification code sent to ${widget.phoneNumber}",
                    style: const TextStyle(fontSize: 13),
                  ),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: verificationCode,
                      keyboardType: TextInputType.number,
                      cursorColor: customPurple,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: customPurple))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 250,
                    height: 45,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext context) {
                                return const SignUp();
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
                        child: const Text("Okay",style: TextStyle(

                            color: kPrimaryColor))),
                    // Column(
                    //   //keypad
                    //   children: [
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       children: [
                    //         TextButton(
                    //             onPressed: () {
                    //             },
                    //             child: const Text(
                    //               "1",
                    //               style: TextStyle(
                    //                   fontSize: 25, color: Colors.black),
                    //             )),
                    //         TextButton(
                    //             onPressed: () {},
                    //             child: const Text(
                    //               "2",
                    //               style: TextStyle(
                    //                   fontSize: 25, color: Colors.black),
                    //             )),
                    //         TextButton(
                    //             onPressed: () {},
                    //             child: const Text(
                    //               "3",
                    //               style: TextStyle(
                    //                   fontSize: 25, color: Colors.black),
                    //             ))
                    //       ],
                    //     ),
                    //     const SizedBox(
                    //       height: 10,
                    //     ),
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       children: [
                    //         TextButton(
                    //             onPressed: () {},
                    //             child: const Text(
                    //               "4",
                    //               style: TextStyle(
                    //                   fontSize: 25, color: Colors.black),
                    //             )),
                    //         TextButton(
                    //             onPressed: () {},
                    //             child: const Text(
                    //               "5",
                    //               style: TextStyle(
                    //                   fontSize: 25, color: Colors.black),
                    //             )),
                    //         TextButton(
                    //             onPressed: () {},
                    //             child: const Text(
                    //               "6",
                    //               style: TextStyle(
                    //                   fontSize: 25, color: Colors.black),
                    //             ))
                    //       ],
                    //     ),
                    //     const SizedBox(
                    //       height: 10,
                    //     ),
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       children: [
                    //         TextButton(
                    //             onPressed: () {},
                    //             child: const Text(
                    //               "7",
                    //               style: TextStyle(
                    //                   fontSize: 25, color: Colors.black),
                    //             )),
                    //         TextButton(
                    //             onPressed: () {},
                    //             child: const Text(
                    //               "8",
                    //               style: TextStyle(
                    //                   fontSize: 25, color: Colors.black),
                    //             )),
                    //         TextButton(
                    //             onPressed: () {},
                    //             child: const Text(
                    //               "9",
                    //               style: TextStyle(
                    //                   fontSize: 25, color: Colors.black),
                    //             ))
                    //       ],
                    //     ),
                    //     const SizedBox(
                    //       height: 10,
                    //     ),
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       children: [
                    //         TextButton(
                    //             onPressed: () {},
                    //             child: const Text(
                    //               "0",
                    //               style: TextStyle(
                    //                   fontSize: 25, color: Colors.black),
                    //             )),
                    //       ],
                    //     ),
                    //   ],
                    // )
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
