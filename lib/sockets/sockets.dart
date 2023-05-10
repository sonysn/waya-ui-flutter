// import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:latlong2/latlong.dart';
import 'package:waya/constants/api_constants.dart';

class ConnectToServer {
  //configure socket transport
  Socket socket = io(
      ApiConstants.baseUrl,
      OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect() // for Flutter or Dart VM
          .build());

  //connect to websockets
  connect(riderID, BuildContext context) {
    //connect to websockets
    if (!socket.connected) {
      //connect to websockets
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
                return const AcceptedRideCard(
                    name: 'John Doe',
                    pickupLocation: '123 Main St.',
                    dropoffLocation: '456 Oak Ave.',
                    fare: 25.00
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

    // // //handle socket events
    socket.on('connect', (_) => print('connect: ${socket.id}'));
    socket.on('disconnect', (_) => print('disconnect'));
  }

  //disconnect from websockets
  disconnect() {
    socket.dispose();
  }

  void listenToDriverLocations() {
    socket.on('driverLocation', (data) => print(LatLng(data[0], data[1])));
  }
}

class AcceptedRideCard extends StatelessWidget {
  final String name;
  final String pickupLocation;
  final String dropoffLocation;
  final double fare;

  const AcceptedRideCard({
    Key? key,
    required this.name,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.fare,
  }) : super(key: key);

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
              Text(
                'Hello, $name is requesting a ride',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'From: $pickupLocation',
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      'To: $dropoffLocation',
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fare: ₦${fare.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          'Accept',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}