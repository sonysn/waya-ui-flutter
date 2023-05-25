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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                const SizedBox(height: 10),
                Text(
                  'Great news!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),


                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(imageUrl),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    const Center(

                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Driver Information',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$driverPhone',
                          style: TextStyle(
                            fontSize: 14,

                          ),
                        ),

                      ],
                    ),

                  ],
                ),  const SizedBox(height: 2),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Vehicle Information',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),


                      ],
                    ),

                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(
                          '$vehicleName - $vehiclePlateNumber',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Color: $vehicleColour',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {

                  },
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
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

  } }
