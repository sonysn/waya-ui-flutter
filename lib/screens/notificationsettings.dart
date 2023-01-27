import 'package:flutter/material.dart';
import 'package:waya/screens/profile/profilepage.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({Key? key}) : super(key: key);

  @override
  State<NotificationSettings> createState() =>
      _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool isSelected = false;

  void toggleSwitch(bool value){
    setState(() {
      isSelected=!isSelected;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
            children: [
              Container(
      padding: const EdgeInsets.only(top: 40),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          "Address",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 20,
        ),
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
            height: 70,
            //width: 350,
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: SizedBox(
              height: 70,
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Home',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '30, ilesanya street ifako lagos',
                        style: TextStyle(fontSize: 10),
                      ),

                    ],
                  ),





                ],
              ),
            ),

          ),

        ),
        const SizedBox(
          height: 20,
        ),
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
            height: 70,
            //width: 350,
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: SizedBox(
              height: 70,
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 25.0,
                    color: Colors.yellow,
                  ),


                  const SizedBox(
                    width: 10,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Office',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '30, ilesanya street ifako lagos',
                        style: TextStyle(fontSize: 10),
                      ),

                    ],
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,



                    children: [
                      const Icon(
                        Icons.edit_location_sharp,
                        size: 25.0,
                        color: Colors.yellow,

                      ),

                    ],
                  )
                ],
              ),
            ),

          ),

        ),

        const SizedBox(
          height: 350,
        ),
        Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const ProfilePage();
                    }));
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                      bottom: Radius.circular(20),
                    ),
                  )),
              child: const SizedBox(
                width: 260,
                height: 50,
                child: Center(child: Text('Update', style: TextStyle(

                    color: Colors.black),)
                ),
              )),
        ),
      ]),
    )
    ],));
  }
}
