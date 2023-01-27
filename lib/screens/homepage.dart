import 'package:flutter/material.dart';
import 'package:time_greeting/time_greeting.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocode/geocode.dart';
import 'package:waya/screens/maphomepage.dart';
import 'package:waya/screens/search_locationpage.dart';
import 'dart:io';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:waya/screens/editprofilepage.dart';
import 'package:waya/size_config.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? profileImageUrl;

  //socket io related code do not tamper!
  void re() async {
    Socket socket = io(
        'http://192.168.216.31:3000',
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .build());
    socket.connect();
    socket.on('connect', (_) => print('connect: ${socket.id}'));
    dynamic data = 'Hello from flutter app';
    socket.emit('location', data);
    //socket.on('messages', (msg) => print(msg));
    //socket.emit(event)
  }

  void findLoc() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationDataSpot;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationDataSpot = await location.getLocation();
    //check if widget is mounted
    if (mounted) {
      setState(() {
        myLocationHome = LatLng(
            double.parse(locationDataSpot.latitude.toString()),
            double.parse(locationDataSpot.longitude.toString()));
        //mapController.move(myLocationHome, 17);
      });
    } else {
      super.dispose();
    }
    print(myLocationHome?.latitude);

    void getAddressLoc() async {
      GeoCode geoCode = GeoCode();

      try {
        Address address = await geoCode.reverseGeocoding(
            latitude: double.parse(locationDataSpot.latitude.toString()),
            longitude: double.parse(locationDataSpot.longitude.toString()));
        setState(() {
          addressLoc = address;
        });
        print(addressLoc);
      } catch (e) {
        print(e);
        getAddressLoc();
      }
    }

    getAddressLoc();
  }

  String? greeting;
  dynamic myLocationHome;
  Address? addressLoc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      greeting = getTimeString();
    });
    findLoc();
  }

  // //disposing of mylocationhome variable
  // @override
  // void dispose() {
  //   myLocationHome;
  //   findLoc();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 15),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${greeting!},",
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w500),
                ),
                const Text(
                  "FirstName",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),

                const SizedBox(
                  height: 50,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Card(
                      color: Colors.white,
                      elevation: 0,
                      borderOnForeground: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                          bottom: Radius.circular(15),
                        ),
                         side: BorderSide(color: Colors.yellow, width: 1),
                      ),
                      child: SizedBox(
                        height: 50,
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.location_on_rounded),
                            Text('Enter pickup point')
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      elevation: 0,
                      borderOnForeground: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                          bottom: Radius.circular(15),
                        ),
                          side: BorderSide(color: Colors.yellow, width: 1),
                      ),
                      child: SizedBox(
                        height: 50,
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.access_time),
                            Text('Schedule ride')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                  width:20,
                ),
                //todo put picture as asset image, J do the next card.
                FittedBox(
                  fit: BoxFit.fitWidth,

                  child: SizedBox(
                    height: 200,
                    child: Card(
                      color: Colors.white,
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                          bottom: Radius.circular(15),
                        ),
                         side: BorderSide(color: Colors.yellow, width: 1),
                      ),
                      child: Row(
                        children: [
                          Image.asset("assets/images/bcar.jpeg"),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "27 rides",
                                style: TextStyle(fontSize: 30),
                              ),
                              const Text(
                                "Around You",
                                style: TextStyle(fontSize: 25),
                              ),
                              Text(
                                "${addressLoc?.streetNumber}, ${addressLoc?.streetAddress}, ${addressLoc?.region}.",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                //TODO PLEASE READ TODOS THANKS!
                // TODO try not to use fitted box unnecessarily, especially with things with no solid dimensions. ALSO ask when that issue with overflowing screen arises

                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: SizedBox(
                      height: 80,
                      width: 350,
                      child: Card(
                        color: Colors.white,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15),
                            bottom: Radius.circular(15),
                          ),
                          side: BorderSide(color: Colors.yellow, width: 1),
                        ),
                        child: Row(

                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.wallet),
                            const SizedBox(
                              width: 75,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Your Balance',
                                  style: TextStyle(fontSize: 18),
                                ),
                                const Text(
                                  "₦10,000.00",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            )
                          ],
                        ),

                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: SizedBox(
                      height: 120,
                      width: 350,
                      child: Card(
                        color: Colors.white,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15),
                            bottom: Radius.circular(15),
                          ),
                            side: BorderSide(color: Colors.yellow, width: 1),
                        ),
                        child: Row(

                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage("assets/images/h.jpeg"),
                            ),

                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Your previous ride with Stephen",
                                  style: TextStyle(fontSize: 18),
                                ),
                                const Text(
                                  "₦500.00",
                                  style: TextStyle(fontSize: 15),
                                ),
                                const Text(
                                  "14 Ilimi Street, Ikeja, Lagos.",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            )
                          ],
                        ),

                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
