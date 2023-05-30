import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waya/api/actions.dart';
import 'package:waya/colorscheme.dart';

class DriverWidget extends StatefulWidget {
  final dynamic data;
  const DriverWidget({Key? key, this.data}) : super(key: key);

  @override
  State<DriverWidget> createState() => _DriverWidgetState();
}

class _DriverWidgetState extends State<DriverWidget> {
  Future getCurrentTripDetails() async {
    final response = await getCurrentRide(userID: widget.data.id);
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
    findLoc();
    getCurrentTripDetails();
  }

  Future _refreshItems() async {
    findLoc();
    getCurrentTripDetails();
  }

  void findLoc() {
    // Implement the logic for finding location here
  }

  @override
  Widget build(BuildContext context) {
    if (driverVehicleName != null) {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [customPurple, Colors.orangeAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(driverPhoto!),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    driverVehicleName!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    driverVehiclePlateNumber!,
                    style: TextStyle(
                      fontSize: 16,
                      color: customPurple,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: IconButton(
                      icon: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: customPurple.withOpacity(0.1),
                        ),
                        child: Icon(
                          Icons.phone,
                          color: customPurple,
                          size: 28,
                        ),
                      ),
                      onPressed: () {
                        launch("tel:$driverPhoneNumber");
                      },
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 3,
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: Icon(
                          Icons.directions_car,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Your Trip",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Text(
                          "₦${fare.toString()}",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: customPurple,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.black,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          pickUpLocation!,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7.0),
                    child: Container(
                      width: 3,
                      height: 20,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.black,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          destination!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Container(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    // Implement the functionality to cancel the trip here
                  },
                  style: ElevatedButton.styleFrom(
                    primary: customPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Text('No Active Rides'),
        ),
      );
    }
  }
}
