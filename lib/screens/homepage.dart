import 'package:flutter/material.dart';
import 'package:waya/screens/drawerpage.dart';
import 'package:time_greeting/time_greeting.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocode/geocode.dart';
import 'package:waya/screens/maphomepage.dart';
import 'package:waya/screens/search_locationpage.dart';
import 'dart:io';
import 'package:socket_io_client/socket_io_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //socket io related code do not tamper!
  void re() async {
    Socket socket = io('http://192.168.216.31:3000',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .build()
    );
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
    setState(() {
      myLocationHome = LatLng(
          double.parse(locationDataSpot.latitude.toString()),
          double.parse(locationDataSpot.longitude.toString()));
      //mapController.move(myLocationHome, 17);
    });
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

  //disposing of mylocationhome variable
  @override
  void dispose(){
    myLocationHome;
    findLoc();
    super.dispose();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10),
            margin: const EdgeInsets.symmetric(horizontal: 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const DrawerPage();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(100),
                            bottom: Radius.circular(100),
                          ),
                        )),
                    child: const Icon(Icons.list_rounded, color: Colors.black)),
                const Text(
                  "Hello name",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                Text(
                  greeting!,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w300),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return MapHomePage(
                            myLocationHome: myLocationHome,
                            addressLoc: addressLoc
                          );
                          //return const SearchLocationPage();
                        }));
                    //re();
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 6,
                    child: Card(
                        elevation: 15,
                        child: Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://img.freepik.com/premium-vector/taxi-city_1270-526.jpg?w=2000"))),
                            ),
                            const Center(
                                child: Text(
                              "Join a Car",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ))
                          ],
                        )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
