import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:qunot/constants/api_constants.dart';
import 'package:qunot/colorscheme.dart';
import 'package:qunot/functions/navigation_logic.dart';

class ConnectToServer {
  // configure socket transport
  Socket socket = io(
    ApiConstants.baseUrl,
    OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect() // for Flutter or Dart VM
        .build(),
  );

  // connect to websockets
  connect(riderID, BuildContext context) {
    // connect to websockets
    if (!socket.connected) {
      // connect to websockets
      String who = 'Rider';
      socket.connect();
      socket.emit("identifyWho", who + riderID.toString());

      void myFunction(BuildContext context) {
        socket.on("acceptedRide?", (data) {
          print(data);

          try {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return AcceptedRideCard(
                  imageUrl: data['driverPhoto'],
                  vehicleName: data['vehicleName'],
                  vehicleColour: data['vehicleColour'],
                  vehiclePlateNumber: data['vehiclePlateNumber'],
                  driverPhone: data['driverPhone'],
                );
              },
            );
            ConnectToServer().disconnect();
          } catch (e) {
            print('Error showing bottom sheet: $e');
          }
        });
      }

      myFunction(context);
    }

    // handle socket events
    socket.on('connect', (_) => print('connect: ${socket.id}'));
    socket.on('disconnect', (_) => print('disconnect'));
  }

  // disconnect from websockets
  disconnect() {
    socket.dispose();
  }

  void listenToDriverLocations() {
    socket.on('driverLocation', (data) => print(LatLng(data[0], data[1])));
  }
}

class AcceptedRideCard extends StatelessWidget {
  final String imageUrl;
  final String vehicleName;
  final String vehiclePlateNumber;
  final String vehicleColour;
  final String driverPhone;

  const AcceptedRideCard({
    Key? key,
    required this.imageUrl,
    required this.vehicleName,
    required this.vehiclePlateNumber,
    required this.vehicleColour,
    required this.driverPhone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          const SizedBox(height: 12),
          const Text(
            'Your Ride Has Been Accepted!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(imageUrl),
              ),
              const SizedBox(height: 12),
              const Text(
                'Driver Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Phone: $driverPhone',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Vehicle Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$vehicleName - $vehiclePlateNumber',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Color: $vehicleColour',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    //IMPLEMENT THE HOMEPAGE NAVIGATION
                    navigateBackThreePages(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customPurple,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                        bottom: Radius.circular(20),
                      ),
                    ),
                  ),
                  child: const SizedBox(
                    width: 260,
                    height: 50,
                    child: Center(
                      child: Text(
                        'OK',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }
}
