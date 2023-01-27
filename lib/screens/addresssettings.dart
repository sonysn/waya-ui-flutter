import 'package:flutter/material.dart';
import 'package:waya/screens/profile/profilepage.dart';

class AddressSettings extends StatefulWidget {
  const AddressSettings({Key? key}) : super(key: key);

  @override
  State<AddressSettings> createState() =>
      _AddressSettingsState();
}

class _AddressSettingsState extends State<AddressSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(

            children: [   const SizedBox(
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
                    color: Colors.black,
                  ),
                ),
                Text(
                    'Address',
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),

              Container(
      padding: const EdgeInsets.only(top: 40),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [

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
                        'Home',
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
    ),SizedBox(
                height: 15,
              ),
    ],));
  }
}
