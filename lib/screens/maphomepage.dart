import 'dart:async';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:waya/functions/map_logic.dart';
import 'package:waya/constants/mapbox_constant.dart';
import 'package:geocode/geocode.dart';

import 'package:waya/screens/homepage.dart';

dynamic driverFound;

// ignore: must_be_immutable
class MapHomePage extends StatefulWidget {
  dynamic myLocationHome;
  Address? addressLoc;

  MapHomePage(
      {Key? key, required this.myLocationHome, required this.addressLoc})
      : super(key: key);

  @override
  State<MapHomePage> createState() => _MapHomePageState();
}

class _MapHomePageState extends State<MapHomePage> {
  //socket io related code
  // void re() async {
  //   Socket socket = io('http://192.168.216.31:3000',
  //       OptionBuilder()
  //           .setTransports(['websocket']) // for Flutter or Dart VM
  //           .build()
  //   );
  //   socket.connect();
  //   socket.on('connect', (_) => print('connect: ${socket.id}'));
  //   //dynamic data = 'Hello from flutter app';
  //   dynamic data = locationAta;
  //   socket.emit('location', data);
  //   //socket.on('messages', (msg) => print(msg));
  //   //socket.emit(event)
  // }

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
      widget.myLocationHome = LatLng(
          double.parse(locationDataSpot.latitude.toString()),
          double.parse(locationDataSpot.longitude.toString()));
      mapController.move(widget.myLocationHome, 17);
    });
    print(locationDataSpot.latitude);

    void getAddressLoc() async {
      GeoCode geoCode = GeoCode();

      try {
        Address address = await geoCode.reverseGeocoding(
            latitude: double.parse(locationDataSpot.latitude.toString()),
            longitude: double.parse(locationDataSpot.longitude.toString()));
        setState(() {
          widget.addressLoc = address;
        });
        //print(address);
      } catch (e) {
        print(e);
      }
    }

    getAddressLoc();
    checkNull();
  }

  //Request for permission, then return continuous location callbacks and setState on the marker myLocationHome
  void locationService() async {
    Location location = Location();
    // Request permission to use location
    location.requestPermission().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {
        // If granted listen to the onLocationChanged stream and emit over our controller
        location.onLocationChanged.listen((locationData) {
          if (mounted) {
            setState(() {
              widget.myLocationHome = LatLng(
                  double.parse(locationData.latitude.toString()),
                  double.parse(locationData.longitude.toString()));
              //mapController.move(myLocationHome, 17);d
            });
          }
          //socket io related code
          // setState(() {
          //   locationAta = locationData.toString();
          //   //locationData = locationAta;
          // });
          //print(locationData);
          //socket io related code
          //re();
        });
      }
    });
  }

  //waits 10 seconds then sets the address text to addressLoc from homepage.dart
  void checkNull() async {
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      addressText =
          "${widget.addressLoc?.streetNumber}, ${widget.addressLoc?.streetAddress}, ${widget.addressLoc?.city}";
    });
  }

  // dynamic myLocationHome = LatLng(51.5090214, -0.1982948);
  String addressText = "Loading...";

  //this is for the marker that handles the users tapped location. initializes as users current location
  dynamic tappedLocationD;

  //socket io related code
  //dynamic locationAta;
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    //print(widget.myLocationHome);
    //findLoc();
    locationService();
    checkNull();
    setState(() {
      tappedLocationD = widget.myLocationHome;
    });
  }

  //todo check this dispose out
  @override
  void dispose() {
    locationService();
    myLocationHome;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              minZoom: 5,
              maxZoom: 18,
              zoom: 15,
              center: widget.myLocationHome,
              //interactiveFlags: InteractiveFlag.all,
              onTap: (tapPosition, LatLng tappedLocation) {
                //to display tapped location on the map
                setState(() {
                  tappedLocationD = tappedLocation;
                });
                print(tappedLocation);
              },
            ),
            mapController: mapController,
            children: [
              TileLayer(
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/osioneboss/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                additionalOptions: const {
                  'mapStyleId': AppConstants.mapBoxStyleId,
                  'accessToken': AppConstants.mapBoxAccessToken,
                },
              ),
              MarkerLayer(
                //user current location on map
                markers: [
                  Marker(
                    point: widget.myLocationHome,
                    width: 40,
                    height: 40,
                    builder: (context) => const Icon(Icons.add_circle_outline),
                  )
                ],
              ),
              MarkerLayer(
                //user current location on map
                markers: [
                  Marker(
                    point: tappedLocationD,
                    width: 40,
                    height: 40,
                    builder: (context) => const Icon(Icons.abc),
                  )
                ],
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 30.0, left: 8.0),
            child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (BuildContext context) {
                  //   return const DrawerPage();
                  // }));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(8),
                ),
                child: const Icon(Icons.list_rounded, color: Colors.black)),
          ),
          Container(
            margin: EdgeInsets.only(
                bottom: 110, //MediaQuery.of(context).size.height / 5.2,
                right: MediaQuery.of(context).size.width / 8.3),
            child: Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: ElevatedButton(
                  onPressed: () {
                    findLoc();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(8),
                  ),
                  child: const Icon(Icons.gps_fixed, color: Colors.black)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                bottom: 110, //MediaQuery.of(context).size.height / 5.2,
                right: MediaQuery.of(context).size.width / 1.4),
            child: Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const HomePage();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(8),
                  ),
                  child: const Icon(Icons.home, color: Colors.black)),
            ),
          ),
          Positioned(
            height: MediaQuery.of(context).size.width / 5,
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    void state() async {
                      //driverFound = await requestRide("${widget.addressLoc?.streetNumber}, ${widget.addressLoc?.streetAddress}, \n${widget.addressLoc?.region}.", "6.501871, 3.373521", tappedLocationD);
                    }
                    state();
                  });
                  //
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return const BottomDialog();
                      });
                  //
                  print(driverFound);
                },
                //style: ElevatedButton.styleFrom(
                //     backgroundColor: customPurple,
                //    shape: const RoundedRectangleBorder(
                //      borderRadius: BorderRadius.vertical(
                //       top: Radius.circular(10),
                //     bottom: Radius.circular(10),
                //    ),
                //  )),
                child: const Text("Request ride")),

            // child: GestureDetector(
            //   onTap: (){
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (BuildContext context) {
            //           return const SearchLocationPage();
            //         }));
            //   },
            //   child: Center(
            //         child: Card(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(50.0),
            //       ),
            //       child: SizedBox(
            //           width: MediaQuery.of(context).size.width / 1.3,
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Row(
            //               children: [
            //                 const Icon(
            //                   Icons.circle,
            //                   color: Colors.yellow,
            //                 ),
            //                 const SizedBox(
            //                   width: 10,
            //                 ),
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     const Text(
            //                       "Where to?",
            //                       style: TextStyle(
            //                           fontSize: 30, fontWeight: FontWeight.bold),
            //                     ),
            //                     //question marks are adding a null check to addressLoc
            //                     Text(addressText)
            //                   ],
            //                 )
            //               ],
            //             ),
            //           )),
            //     )),
            // ),
          )
        ],
      ),
    );
  }
}

class BottomDialog extends StatefulWidget {
  const BottomDialog({Key? key}) : super(key: key);

  @override
  State<BottomDialog> createState() => _BottomDialogState();
}

class _BottomDialogState extends State<BottomDialog> {
  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: mHeight * 0.5,
      width: mWidth,
      child: const Column(
        children: [
          LinearProgressIndicator(),
          Text('Searching for a driver')
        ],
      ),
    );
  }
}
