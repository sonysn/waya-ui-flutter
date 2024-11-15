import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:time_greeting/time_greeting.dart';
import 'package:qunot/functions/miscellaneous.dart';
import 'package:qunot/functions/notification_service.dart';
import 'package:qunot/screens/widgets/activeride.dart';
import 'package:location/location.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:qunot/api/actions.dart';
import 'package:qunot/colorscheme.dart';
import 'package:qunot/screens/mapspage.dart';
// ignore: library_prefixes
import 'package:geocoding/geocoding.dart' as locationGeocodingPackage;

class HomePage extends StatefulWidget {
  final dynamic data;
  const HomePage({Key? key, this.data}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

ValueNotifier<bool> fetchHomepageNotifier = ValueNotifier<bool>(false);

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
              "${capitalizeFirstLetter(place.street)}, ${place.subAdministrativeArea}, ${place.administrativeArea}";
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

  Future getCurrentTripDetails() async {
    final response = await getCurrentRide(
        userID: widget.data.id, authBearer: widget.data.authToken);
    //print(response);
    if (response == null) {
      setState(() {
        driverPhoto = null;
        driverVehicleName = null;
        driverVehiclePlateNumber = null;
        vehicleColour = null;
        driverPhoneNumber = null;
        pickUpLocation = null;
        destination = null;
        fare = null;
      });
    } else {
      setState(() {
        driverPhoto = response['driverPhoto'];
        driverVehicleName = response['vehicleName'];
        driverVehiclePlateNumber = response['vehiclePlateNumber'];
        vehicleColour = response['vehicleColour'];
        driverPhoneNumber = response['driverPhone'];
        pickUpLocation = response['pickUpLocation'];
        destination = response['destinationLocation'];
        fare = response['fare'];
      });
    }
  }

  void _fetchDataValueNotifier() {
    if (fetchHomepageNotifier.value) {
      refreshHomePage();
      fetchHomepageNotifier.value = false;
    }
  }

  String? greeting;
  dynamic myLocationHome;
  String? addressLoc;
  dynamic driverCounter;

  //CURRENT TRIP DETAILS
  String? driverPhoto;
  String? driverVehicleName;
  String? driverVehiclePlateNumber;
  String? vehicleColour;
  String? driverPhoneNumber;
  String? pickUpLocation;
  String? destination;
  int? fare;

  @override
  void initState() {
    super.initState();
    fetchHomepageNotifier.addListener(_fetchDataValueNotifier);
    setState(() {
      greeting = getTimeString();
    });
    findLoc();
    getCurrentTripDetails();

    // Request permission for receiving push notifications (only for iOS)
    FirebaseMessaging.instance.requestPermission();

    // Configure Firebase Messaging & Show Notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message: ${message.notification?.title}');
      //For Rides
      NotificationService().showRideNotification(
          dataTitle: '${message.notification?.title}',
          dataBody: '${message.notification?.body}');

      //For General Notifications
      NotificationService().showNotifications(
          dataTitle: '${message.notification?.title}',
          dataBody: '${message.notification?.body}');
    });
  }

  int refreshCount = 0;

  Future<void> refreshHomePage() async {
    // Simulate an asynchronous operation
    findLoc();
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      refreshCount++;
    });
  }

  // //disposing of mylocationhome variable
  @override
  void dispose() {
    fetchHomepageNotifier.removeListener(_fetchDataValueNotifier);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth;
        final double height = constraints.maxHeight;
        // ignore: unused_local_variable
        final double padding = width > 600 ? 40 : 20;

        return RefreshIndicator(
          color: Colors.orangeAccent,
          backgroundColor: customPurple,
          onRefresh: refreshHomePage,
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
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  widget.data?.firstName ?? '',
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
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
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Colors.white,
                                                  Colors.orangeAccent
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                top: Radius.circular(15),
                                                bottom: Radius.circular(15),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: SizedBox(
                                              height: 60,
                                              width: width / 1.1,
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons
                                                        .location_on_rounded),
                                                    Text('Enter pickup point')
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                          return MapsPage(data: widget.data);
                                        }));
                                      },
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
                                                  style:
                                                      TextStyle(fontSize: 25),
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
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: SizedBox(
                                    height: 80,
                                    width: width,
                                    child: Card(
                                      elevation: 5,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(15),
                                          bottom: Radius.circular(15),
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              customPurple,
                                              Colors.orangeAccent
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            top: Radius.circular(15),
                                            bottom: Radius.circular(15),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 5,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 4,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(width: 10),
                                              const Icon(
                                                Icons.wallet,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(width: 15),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Your Balance',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    "₦${widget.data?.accountBalance ?? ''}",
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ]),
                        ),
                        ActiveRide(
                          userID: widget.data.id,
                          authToken: widget.data.authToken,
                          refreshCount: refreshCount,
                          onRefreshHomePage: refreshHomePage,
                        ),
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
