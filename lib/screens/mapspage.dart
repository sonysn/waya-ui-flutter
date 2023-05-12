import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geocode/src/model/address.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:waya/api/actions.dart';
import 'package:geocoding/geocoding.dart' as locationGeocodingPackage;

import '../colorscheme.dart';
import '../sockets/sockets.dart';

class MapsPage extends StatefulWidget {
  final dynamic data;

  const MapsPage({Key? key, this.data}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

dynamic _dropOffLocation;
dynamic _currentLocation;
dynamic _dropOffLocationAddress;
dynamic _currentLocationAddress;
bool showButtonWidget = false;

class _MapsPageState extends State<MapsPage> {
  late GoogleMapController mapController;
  late final LatLng _center = _currentLocation;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
    location.enableBackgroundMode(enable: true);
    //check if widget is mounted
    if (mounted) {
      setState(() {
        _currentLocation = LatLng(
            double.parse(locationDataSpot.latitude.toString()),
            double.parse(locationDataSpot.longitude.toString()));
        //mapController.move(myLocationHome, 17);
      });
    } else {
      super.dispose();
    }
    print(_currentLocation);
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findLoc();
    ConnectToServer().connect(widget.data.id, context);
  }

  @override
  void dispose() {
    super.dispose();
    ConnectToServer().disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: _currentLocation != null
            ? SafeArea(
                child: Stack(children: [
                  GoogleMap(
                    markers: <Marker>{
                      Marker(
                        markerId: const MarkerId("1"),
                        position: _center,
                      ),
                    },
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 14.0,
                    ),
                    onTap: (position) {
                      print(position);
                    },
                  ),
                  const MySearchBar(),
                  Container(
                      margin: EdgeInsets.only(
                          bottom:
                              20, //MediaQuery.of(context).size.height / 5.2,
                          right: MediaQuery.of(context).size.width / 250),
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: ElevatedButton(
                                onPressed: () {
                                  findLoc();
                                  mapController.animateCamera(
                                      CameraUpdate.newLatLngZoom(
                                          LatLng(_center.latitude,
                                              _center.longitude),
                                          14));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(8),
                                ),
                                child: const Icon(Icons.gps_fixed,
                                    color: Colors.black)),
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: Visibility(
                              visible: showButtonWidget,
                              child: ElevatedButton(
                                  onPressed: () async{

                                    final res = await getRidePrice(currentLocationPoint: _currentLocation, dropOffLocationPoint: _dropOffLocation);

                                    if(res != null){
                                      void request(){
                                        requestRide(
                                            userID: widget.data.id,
                                            currentLocationAddress: _currentLocationAddress,
                                            dropOffLocationAddress: _dropOffLocationAddress,
                                            fare: double.parse(res.toString()).ceil(),
                                            currentLocationPoint: _currentLocation,
                                            dropOffLocationPoint:  _dropOffLocation,
                                            authBearer:  widget.data.token);
                                      }
                                      try {
                                        showModalBottomSheet<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            //rounds up the price to larger whole number
                                            return CheckPrice(price: double.parse(res.toString()).ceil(), buttonPress: request);
                                          },
                                        );
                                      } catch (e) {
                                        print('Error showing bottom sheet: $e');
                                      }
                                    }

                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.all(18),
                                      disabledBackgroundColor: Colors.grey),
                                  child: const Text(
                                    'Request ride',
                                    style: TextStyle(color: Colors.black),
                                  )),
                            ),
                          ),
                        ],
                      )),
                ]),
              )
            : const Center(child: Text('Loading...')));
  }
}

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  _MySearchBarState createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final _locationController = TextEditingController();
  final _destinationController = TextEditingController();
  late final Location location;

  @override
  void initState() {
    super.initState();

    // Initialize the Location object
    location = Location();

    // Add a listener to the destination text field so that we can update the destination address
    // whenever the user types a new location
    _destinationController.addListener(() {
      getDestinationAddress();
    });
  }

  @override
  void dispose() {
    // Clean up the text field controllers when the widget is disposed
    _locationController.dispose();
    _destinationController.dispose();

    super.dispose();
  }

  Future<void> _findMyLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

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

    locationData = await location.getLocation();
    // if (mounted) {
    //   _locationController.text =
    //   "${locationData.latitude}, ${locationData.longitude}";
    // }
    getAddress(
        latitude: locationData.latitude, longitude: locationData.longitude);
  }

  //TODO CHECK IF THESE ARE NULL BEFORE SHOWING THE REQUEST RIDE BUTTON
  void checkTripDataNull() {
    if (_currentLocation != null && _dropOffLocation != null) {
      setState(() {
        showButtonWidget = true;
      });
    }
  }

  //Gets coordinates from the _findMyLocation function and returns the address to the Location text controller
  Future<void> getAddress(
      {required double? latitude, required double? longitude}) async {
    List placeMarks = await locationGeocodingPackage.placemarkFromCoordinates(
        latitude!, longitude!);
    locationGeocodingPackage.Placemark place = placeMarks[0];
    print(place.name); // prints the street address
    print(place.street); // prints the city
    print(place.subAdministrativeArea);
    print(place.administrativeArea); // prints the state
    print(place.country); // prints the country
    print(place.postalCode); // prints the postal code
    //print(placeMarks);
    _locationController.text =
        "${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}";
    setState(() {
      _currentLocationAddress = "${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}";
    });
  }

  //Gets address text from the destinationController text fields and returns the coordinates to the _dropOffLocation variable which would be submitted to the server
  Future getDestinationAddress() async {
    List destinationPlaceMark = await locationGeocodingPackage
        .locationFromAddress("${_destinationController.text}, Lagos");
    print(
        "${destinationPlaceMark[0].latitude}, ${destinationPlaceMark[0].longitude}");
    setState(() {
      _dropOffLocation = [
        destinationPlaceMark[0].latitude,
        destinationPlaceMark[0].longitude
      ];
      _dropOffLocationAddress = "${_destinationController.text}, Lagos";
    });
    checkTripDataNull();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 450),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          TextField(
            readOnly: true,
            cursorColor: Colors.black,
            controller: _locationController,
            decoration: InputDecoration(
              labelText: 'Location',
              labelStyle: const TextStyle(color: Colors.black),
              suffixIcon: IconButton(
                icon: const Icon(Icons.my_location, color: Colors.black),
                onPressed: _findMyLocation,
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          TextField(
            cursorColor: Colors.black,
            controller: _destinationController,
            decoration: const InputDecoration(
              labelText: 'Destination',
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//TODO DESIGN THIS
class CheckPrice extends StatelessWidget {
  final int price;
  final Function buttonPress;

  const CheckPrice({Key? key, required this.price, required this.buttonPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 220,
        child: Card(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Card(
                        elevation: 0,
                        color: Colors.black,
                        child: SizedBox(
                          height: 7,
                          width: MediaQuery.of(context).size.width / 2.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text("Your Trip will cost ₦$price"),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                          onPressed: () async { buttonPress(); },
                          style: ElevatedButton.styleFrom(
                              primary: customPurple,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                  bottom: Radius.circular(20),
                                ),
                              )),
                          child: const SizedBox(
                            width: 260,
                            height: 50,
                            child: Center(child: Text('Request Ride')),
                          )),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                          onPressed: () async { Navigator.pop(context); },
                          style: ElevatedButton.styleFrom(
                              primary: customPurple,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                  bottom: Radius.circular(20),
                                ),
                              )),
                          child: const SizedBox(
                            width: 260,
                            height: 50,
                            child: Center(child: Text('Cancel')),
                          )),
                    ),
                  ])),
        ));
  }
}