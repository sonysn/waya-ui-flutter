import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:waya/colorscheme.dart';

import '../mapbox_constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    setState(() {
      myLocationHome = LatLng(double.parse(_locationData.latitude.toString()),
          double.parse(_locationData.longitude.toString()));
      mapController.move(myLocationHome, 17);
    });
    print(_locationData.latitude);
  }

  dynamic myLocationHome = LatLng(51.5090214, -0.1982948);
  MapController mapController = MapController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findLoc();
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
              center: myLocationHome,
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
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 25.0, left: 8.0),
            child: ElevatedButton(
                onPressed: () {
                  findLoc();
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
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 100, right: 40),
            child: Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: ElevatedButton(
                  onPressed: () {
                    findLoc();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(100),
                          bottom: Radius.circular(100),
                        ),
                      )),
                  child: const Icon(Icons.gps_fixed, color: Colors.black)),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 30,
              height: MediaQuery.of(context).size.height * 0.135,
              child: Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                  child: SizedBox(
                    width:  MediaQuery.of(context).size.width/1.3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Icon(Icons.circle, color: Colors.yellow,),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Where to?", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    )
                  ),
              )))
        ],
      ),
    );
  }
}
