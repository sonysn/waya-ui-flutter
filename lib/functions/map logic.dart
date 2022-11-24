import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';

void findLoc() async {
  Location location = Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  _locationData = await location.getLocation();
  myLocationHome = LatLng(double.parse(_locationData.latitude.toString()),
      double.parse(_locationData.longitude.toString()));
  mapController.move(myLocationHome, 17);
  print(_locationData.latitude);
}

locationService() {
  Location location = Location();
  // Request permission to use location
  location.requestPermission().then((permissionStatus) {
    // If granted listen to the onLocationChanged stream and emit over our controller
    location.onLocationChanged.listen((locationData) {
      myLocationHome = LatLng(double.parse(locationData.latitude.toString()),
          double.parse(locationData.longitude.toString()));
      //mapController.move(myLocationHome, mapController.zoom);
      print(locationData);
    });
  });
}

LatLng myLocationHome = LatLng(51.5090214, -0.1982948);
MapController mapController = MapController();
