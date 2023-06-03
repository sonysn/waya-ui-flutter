import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart' as locationGeocodingPackage;
import 'package:location/location.dart';
import 'dart:convert';

import 'package:waya/colorscheme.dart';

class TripSearchPage extends StatefulWidget {
  const TripSearchPage({Key? key}) : super(key: key);

  @override
  TripSearchPageState createState() => TripSearchPageState();
}

class TripSearchPageState extends State<TripSearchPage> {
  Future<void> _findMyLocation() async {
    Location location = Location();
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

  Future<void> getAddress(
      {required double? latitude, required double? longitude}) async {
    List placeMarks = await locationGeocodingPackage.placemarkFromCoordinates(
        latitude!, longitude!);
    locationGeocodingPackage.Placemark place = placeMarks[0];
    // print(place.name); // prints the street address
    // print(place.street); // prints the city
    // print(place.subAdministrativeArea);
    // print(place.administrativeArea); // prints the state
    // print(place.country); // prints the country
    // print(place.postalCode); // prints the postal code
    // //print(placeMarks);
    _locationController.text =
        "${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}";
  }

  Future getDestinationAddress({required String addressData}) async {
    String apiKey = mapApiKey!; // Replace with your own API key
    // List destinationPlaceMark =
    //     await locationGeocodingPackage.locationFromAddress(addressData);
    // print(
    //     "${destinationPlaceMark[0].latitude}, ${destinationPlaceMark[0].longitude}");

    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$addressData&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // print(data['results'][0]['formatted_address']);
      // print(data['results'][0]['geometry']['location']);
      return [
        data['results'][0]['geometry']['location']['lat'],
        data['results'][0]['geometry']['location']['lng']
      ];
    }
  }

  Future<void> _fetchSuggestions(String input) async {
    String apiKey = mapApiKey!; // Replace with your own API key
    const countryCode = "NG";
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&components=country:$countryCode&key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final predictions = data['predictions'] as List<dynamic>;
      final suggestions = predictions
          .map((prediction) => prediction['description'] as String)
          .toList();

      setState(() {
        _suggestions = suggestions;
      });
    }
  }

  Future<void> getApikey() async {
    const url = 'https://sea-lion-app-m46xn.ondigitalocean.app/getAPIKEY';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        mapApiKey = data['KEY'];
      });
      // print(data['KEY']);
    }
  }

  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  List<String> _suggestions = [];
  bool? isTyping;
  bool showButtonWidget = false;
  String? mapApiKey;

  @override
  void initState() {
    super.initState();
    getApikey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Form(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  children: [
                    TextFormField(
                      onTap: () {
                        setState(() {
                          isTyping = true;
                        });
                      },
                      controller: _locationController,
                      onChanged: _fetchSuggestions,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Location',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: SvgPicture.asset(
                            'assets/icons/location.svg',
                            color: Colors.black, // Set icon color to black
                            height: 24.0,
                          ),
                        ),
                        fillColor:
                            Colors.grey[150], // Set light grey background
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                        height: 16.0), // Add spacing between the text fields
                    TextFormField(
                      onTap: () {
                        setState(() {
                          isTyping = false;
                        });
                      },
                      controller: _destinationController,
                      onChanged: _fetchSuggestions,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: 'Enter destination',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: SvgPicture.asset(
                            'assets/icons/location_icon.svg',
                            color: Colors.black, // Set icon color to black
                            height: 24.0,
                          ),
                        ),
                        fillColor:
                            Colors.grey[150], // Set light grey background
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: double.infinity, // Expand width to the end
                        decoration: BoxDecoration(
                          color: Colors.grey[300], // Set light grey background
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextButton.icon(
                          onPressed: () {
                            _findMyLocation();
                          },
                          icon: SvgPicture.asset(
                            'assets/icons/share.svg',
                            color: Colors.black, // Set icon color to black
                            height: 24.0,
                            width: 24.0,
                          ),
                          label: const Text(
                            'Use My Current Location',
                            style: TextStyle(
                              fontSize: 16.0, // Set font size to 16
                              fontWeight:
                                  FontWeight.bold, // Set font weight to bold
                              color: Colors.black, // Set text color to black
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: SvgPicture.asset(
                      'assets/icons/location.svg',
                      color: Colors.black, // Set icon color to black
                      height: 24.0,
                    ),
                    title: Text(_suggestions[index]),
                    onTap: () {
                      if (isTyping == true) {
                        _locationController.text = _suggestions[index];
                        setState(() {
                          _suggestions = []; // Clear suggestions
                        });
                      } else {
                        _destinationController.text = _suggestions[index];
                        setState(() {
                          _suggestions = []; // Clear suggestions
                        });
                      }
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final locData = await getDestinationAddress(
                    addressData: _locationController.text);
                final desData = await getDestinationAddress(
                    addressData: _destinationController.text);

                void moveback() {
                  Navigator.pop(
                      context,
                      PassedBackData(_locationController.text,
                          _destinationController.text, locData, desData, true));
                }

                moveback();
              },
              child: Text('OK'),
              style: ElevatedButton.styleFrom(
                  primary: customPurple,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                      bottom: Radius.circular(20),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class PassedBackData {
  final String locationAdress;
  final String destinationAdress;
  final List locData;
  final List desData;
  final bool status;
  PassedBackData(this.locationAdress, this.destinationAdress, this.locData,
      this.desData, this.status);
}
