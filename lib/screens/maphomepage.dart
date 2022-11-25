import 'dart:async';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:waya/colorscheme.dart';
import 'package:waya/screens/drawerpage.dart';
import '../constants/mapbox constant.dart';
import 'package:geocode/geocode.dart';

import 'homepage.dart';

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
              //mapController.move(myLocationHome, 17);
            });
          }
          print(locationData);
        });
      }
    });
  }

  void checkNull() async {
    await Future.delayed(const Duration(seconds: 10));
    setState(() {
      addressText =
          "${widget.addressLoc?.streetNumber}, ${widget.addressLoc?.streetAddress}, ${widget.addressLoc?.city}";
    });
  }

  // dynamic myLocationHome = LatLng(51.5090214, -0.1982948);
  String addressText = "Loading...";
  //this is for the marker that handles the users tapped location. initializes as users current location
  dynamic tappedLocationD;
  MapController mapController = MapController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print(widget.myLocationHome);
    //findLoc();
    locationService();
    checkNull();
    setState(() {
      tappedLocationD = widget.myLocationHome;
    });
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
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 25.0, left: 8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const DrawerPage();
                  }));
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
                bottom: 100, //MediaQuery.of(context).size.height / 5.2,
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
                bottom: 100, //MediaQuery.of(context).size.height / 5.2,
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
              left: 0,
              right: 0,
              bottom: 25,
              height: 70,
              //MediaQuery.of(context).size.height * 0.2,
              child: Center(
                  child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            color: Colors.yellow,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Where to?",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              //question marks are adding a null check to addressLoc
                              Text(addressText)
                            ],
                          )
                        ],
                      ),
                    )),
              )))
        ],
      ),
    );
  }
}
