import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:time_greeting/time_greeting.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocode/geocode.dart';
import 'package:waya/api/actions.dart';
import 'package:waya/colorscheme.dart';
import 'package:waya/screens/maphomepage.dart';
import 'package:waya/screens/mapspage.dart';
import 'package:waya/screens/search_locationpage.dart';
import 'dart:io';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:waya/screens/editprofilepage.dart';
import 'package:waya/size_config.dart';
import 'package:geocoding/geocoding.dart' as locationGeocodingPackage;

class HomePage extends StatefulWidget {
  final dynamic data;
  const HomePage({Key? key, this.data}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? profileImageUrl;

  //DRIVER COUNT CODE IS IN HERE
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
      List placeMarks = await locationGeocodingPackage.placemarkFromCoordinates(
          double.parse(locationDataSpot.latitude.toString()),
          double.parse(locationDataSpot.longitude.toString()));

      try {
        locationGeocodingPackage.Placemark place = placeMarks[0];
        setState(() {
          addressLoc =
              "${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}";
        });
        print(addressLoc);
      } catch (e) {
        print(e);
      }
    }

    getAddressLoc();
    Future<void> updateDriverCount() async {
      // Get driver count and wait for the result to complete
      final count = await driverCount(
          "${double.parse(locationDataSpot.latitude.toString())}, ${double.parse(locationDataSpot.longitude.toString())}");

      // Update state with the driver count
      setState(() {
        driverCounter = count;
      });
    }

    updateDriverCount();
  }

  String? greeting;
  dynamic myLocationHome;
  String? addressLoc;
  dynamic driverCounter;

  @override
  void initState() {
    super.initState();
    setState(() {
      greeting = getTimeString();
    });
    findLoc();
  }

  Future _refreshItems() async {
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth;
        final double height = constraints.maxHeight;
        final double padding = width > 600 ? 40 : 20;

        return RefreshIndicator(
          color: Colors.orangeAccent,
          backgroundColor: customPurple,
          onRefresh: _refreshItems,
          child: Scaffold(
              body: addressLoc != null
                  ? ListView(
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
                              Text(
                                widget.data.firstName,
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w500),
                              ),

                              const SizedBox(
                                height: 30,
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 5,
                                      borderOnForeground: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(15),
                                          bottom: Radius.circular(15),
                                        ),
                                        // side: BorderSide(color: Colors.white, width: 1),
                                      ),
                                      child: SizedBox(
                                        height: 60,
                                        width: width / 2.2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.location_on_rounded),
                                              Text('Enter pickup point')
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (BuildContext context) {
                                        return MapsPage(data: widget.data);
                                      }));
                                    },
                                  ),
                                  Card(
                                    color: Colors.white,
                                    elevation: 5,
                                    borderOnForeground: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15),
                                        bottom: Radius.circular(15),
                                      ),
                                      //   side: BorderSide(color: Colors.yellow, width: 1),
                                    ),
                                    child: SizedBox(
                                      height: 60,
                                      width: width / 2.5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.access_time),
                                            Text('Schedule ride')
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                                //width: 20,
                              ),
                              //todo put picture as asset image, J do the next card.
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: SizedBox(
                                  height: height * 0.2,
                                  width: width,
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 5,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10),
                                        bottom: Radius.circular(15),
                                      ),
                                      //     side: BorderSide(color: Colors.yellow, width: 1),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/bcar.jpeg",
                                            fit: BoxFit.fill,
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              driverCounter != null
                                                  ? Text(
                                                      driverCounter == 1
                                                          ? "$driverCounter ride"
                                                          : driverCounter == 0
                                                              ? "No rides"
                                                              : "$driverCounter rides",
                                                      style: const TextStyle(
                                                          fontSize: 30),
                                                    )
                                                  : const CircularProgressIndicator(
                                                      color: Colors.black,
                                                      strokeWidth: 2,
                                                    ),
                                              const Text(
                                                "Around You",
                                                style: TextStyle(fontSize: 25),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  addressLoc!,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  style: const TextStyle(
                                                      fontSize: 10),
                                                ),
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
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              //TODO PLEASE READ TODOS THANKS!
                              // TODO try not to use fitted box unnecessarily, especially with things with no solid dimensions. ALSO ask when that issue with overflowing screen arises

                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: SizedBox(
                                    height: 80,
                                    width: width,
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 5,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(15),
                                          bottom: Radius.circular(15),
                                        ),
                                        //      side: BorderSide(color: Colors.yellow, width: 1),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Icon(Icons.wallet),
                                            const SizedBox(
                                              width: 75,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  'Your Balance',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Text(
                                                  "₦${widget.data.accountBalance}",
                                                  style: const TextStyle(
                                                      fontSize: 15),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
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
                                    width: width,
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 5,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(15),
                                          bottom: Radius.circular(15),
                                        ),
                                        //      side: BorderSide(color: Colors.yellow, width: 1),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const CircleAvatar(
                                              radius: 30,
                                              backgroundImage: AssetImage(
                                                  "assets/images/h.jpeg"),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                Text(
                                                  "Your previous ride with Stephen",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Text(
                                                  "₦500.00",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                                Text(
                                                  "14 Ilimi Street, Ikeja, Lagos.",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : Center(
                      child: LoadingAnimationWidget.waveDots(
                          color: Colors.black, size: 70),
                    )),
        );
      },
    );
  }
}
