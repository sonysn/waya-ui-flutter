import 'package:flutter/material.dart';
import 'package:waya/colorscheme.dart';
import 'package:waya/screens/editprofilepage.dart';

import 'messagesnotificationpage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //this will hold profile picture url
  String? profileImageUrl;

  // String profileImageUrl =
  //     'https://media.istockphoto.com/id/1270067126/photo/smiling-indian-man-looking-at-camera.jpg?s=612x612&w=0&k=20&c=ovIQ5GPurLd3mOUj82jB9v-bjGZ8updgy1ACaHMeEC0=';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'FirstName \nLastName',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const EditProfilePage();
                            }));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                //this checks if profileImageUrl is null and returns blank profile picture from this link todo set this to asset image
                                image: profileImageUrl != null
                                    ? NetworkImage(profileImageUrl!)
                                    : const NetworkImage(
                                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'))),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Card(
                      color: Colors.white70,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                          bottom: Radius.circular(15),
                        ),
                      ),
                      child: SizedBox(
                        height: 80,
                        width: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.settings),
                            Text('Settings')
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.white70,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                          bottom: Radius.circular(15),
                        ),
                      ),
                      child: SizedBox(
                        height: 80,
                        width: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [Icon(Icons.history), Text('Trips')],
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.white70,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                          bottom: Radius.circular(15),
                        ),
                      ),
                      child: SizedBox(
                        height: 80,
                        width: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [Icon(Icons.wallet), Text('Wallet')],
                        ),
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const MessagesNotificationPage();
                        }));
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.mail,
                      color: Colors.black,
                    ),
                    title: Text("Messages"),
                  ),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.help,
                    color: Colors.black,
                  ),
                  title: Text("Help"),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.info,
                    color: Colors.black,
                  ),
                  title: Text("Legal"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
