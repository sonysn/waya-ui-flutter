// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';

Future findLoc() async {
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
  myLocationHome = LatLng(double.parse(locationData.latitude.toString()),
      double.parse(locationData.longitude.toString()));
  mapController.move(myLocationHome, 17);
  print(locationData.latitude);
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
