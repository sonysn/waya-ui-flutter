import 'package:socket_io_client/socket_io_client.dart';
import 'package:latlong2/latlong.dart';

class ConnectToServer {
  //configure socket transport
  Socket socket = io(
      'http://192.168.100.43:3000',
      OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
          .build());

  //connect to websockets
  connect(){
    //connect to websockets
    socket.connect();

    // //handle socket events
    // socket.on('connection', (_) => print('connect: ${socket.id}'));
    // socket.on('disconnect', (_) => print('disconnect'));
  }

  //disconnect from websockets
  disconnect(){
    socket.disconnect();
  }

  void listenToDriverLocations(){
    socket.on('driverLocation', (data) => print(LatLng(data[0], data[1])));
  }
}