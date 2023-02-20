import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

//todo base uri value here
var baseUri = 'http://192.168.100.43:3000';

//testing code
Future requestRide(
    currentLocationAddress, dropOffLocationAddress, currentLocationPoint, dropOffLocationPoint) async {
  final http.Response response =
      await http.post(Uri.parse('$baseUri${ApiConstants.requestRideEndpoint}'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": 'Bearer eyJhbGciOiJIUzI1NiJ9.KzIzNDkwNTkxODIwODU1OQ.VEMOKAI45gu8It-J1R1eV7RpinfMzaEi0NhRpaIM-OI'
          },
          body: jsonEncode({
            "userId": 59,
            "pickupLocation": currentLocationAddress,
            "dropoffLocation": dropOffLocationAddress,
            "estFare": 500,
            "surge": 0,
            "pickupLocationPosition": currentLocationPoint,
            "dropoffLocationPostion": dropOffLocationPoint,
            "status": "ONGOING"
          }));
  final data = await jsonDecode(response.body);
  print(data);
  return data;
}
