import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waya/api/actions.dart';
import 'package:waya/colorscheme.dart';

class ActiveRide extends StatefulWidget {
  final dynamic userID;
  const ActiveRide({Key? key, this.userID}) : super(key: key);

  @override
  State<ActiveRide> createState() => _ActiveRideState();
}

class _ActiveRideState extends State<ActiveRide> {
  Future getCurrentTripDetails() async {
    final response = await getCurrentRide(userID: widget.userID);
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
        driverID = null;
        dbObjectID = null;
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
        driverID = response['driverID'];
        dbObjectID = response['objectId'];
      }); _refreshItems(); // Refresh the page
    }
  }

  Future riderCancelTrip() async {
    final response = await onRiderCancelRide(
        riderID: widget.userID, driverID: driverID!, dbObjectID: dbObjectID!);
    if (response == 200) {
      setState(() {
        driverPhoto = null;
        driverVehicleName = null;
        driverVehiclePlateNumber = null;
        vehicleColour = null;
        driverPhoneNumber = null;
        pickUpLocation = null;
        destination = null;
        fare = null;
        driverID = null;
      });
    }
  }

  void dialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Ride'),
          content: const Text(
            'Are you sure you want to cancel the trip?',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Perform the cancel trip action
               riderCancelTrip();
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                backgroundColor: Colors.orangeAccent,
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _refreshItems();
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                backgroundColor: Colors.grey,
              ),
              child: const Text(
                'No',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
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
  int? driverID;
  double? rating;
  String? dbObjectID;

  @override
  void initState() {
    super.initState();
    findLoc();
    getCurrentTripDetails();
    rating = 0;
  }

  Future _refreshItems() async {
    findLoc();
    getCurrentTripDetails();
  }

  void findLoc() {
    // Implement the logic for finding location here
  }

  void _submitRating() {
    // Implement the logic to submit the rating
    print('Rating: $rating');
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
                    decoration: const BoxDecoration(
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
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    driverVehiclePlateNumber!,
                    style: const TextStyle(
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
                        child: const Icon(
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
              const Divider(
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
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: const Icon(
                          Icons.directions_car,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
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
                          style: const TextStyle(
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
                      const Icon(
                        Icons.location_on,
                        color: Colors.black,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          pickUpLocation!,
                          style: const TextStyle(
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
                      const Icon(
                        Icons.location_on,
                        color: Colors.black,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          destination!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        rating = index + 1.toDouble();
                      });
                      //print(rating);
                    },
                    icon: Icon(
                      Icons.star,
                      color: rating != null && index < rating!
                          ? Colors.yellow
                          : Colors.grey,
                      size: 40,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    // Implement the functionality to cancel the trip here
                    dialog();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: customPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
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
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Text(''),
        ),
      );
    }
  }
}
