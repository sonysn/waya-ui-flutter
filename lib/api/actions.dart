import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

//todo base uri value here
var baseUri = 'http://192.168.100.43:3000';

//testing code
Future requestRide({
  required int userID,
  required String currentLocationAddress,
  required String dropOffLocationAddress,
  required int fare,
  required dynamic currentLocationPoint,
  required dynamic dropOffLocationPoint,
  required String authBearer,
}) async {
  final http.Response response =
      await http.post(Uri.parse('$baseUri${ApiConstants.requestRideEndpoint}'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": 'Bearer $authBearer'
          },
          body: jsonEncode({
            "userId": userID,
            "pickupLocation": currentLocationAddress,
            "dropoffLocation": dropOffLocationAddress,
            "estFare": fare,
            "pickupLocationPosition": currentLocationPoint,
            "dropoffLocationPostion": dropOffLocationPoint,
            "status": "ONGOING"
          }));
  final data = await jsonDecode(response.body);
  // print(data);
  return data;
}

Future getRidePrice({required dynamic currentLocationPoint, required dynamic dropOffLocationPoint}) async {
  final http.Response response =
  await http.post(Uri.parse('$baseUri${ApiConstants.getRidePrice}'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "pickupLocationPosition": currentLocationPoint,
        "dropoffLocationPostion": dropOffLocationPoint
      }));
  final data = await jsonDecode(response.body);
  print(data);
  return data;
}

Future getBalance(id, phone) async {
  final http.Response response =
  await http.post(Uri.parse('$baseUri${ApiConstants.getBalanceEndpoint}'),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        'id': id,
        'phoneNumber': phone,
      }));
  final data = json.decode(response.body);
  final d = data['balance'].toString();
  return d;
}
