import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../models/auth.dart';

//todo base uri value here
// var baseUri = 'http://192.168.100.43:3000';
var baseUri = 'https://waya-api.onrender.com';

class SignUpResponse {
  final dynamic body;
  final int? statusCode;

  SignUpResponse(this.body, this.statusCode);
}

Future signUp(
    {required String firstname,
    required String lastname,
    required phoneNumber,
    required password,
    required String email,
    required String homeAddress,
    required String dob}) async {
  final http.Response response =
      await http.post(Uri.parse('$baseUri${ApiConstants.signUpEndpoint}'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "firstname": firstname,
            "lastname": lastname,
            "phoneNumber": phoneNumber,
            "password": password,
            "email": email,
            "address": homeAddress,
            "dob": dob
          }));

  if (response.statusCode == 200) {
    debugPrint('Data submitted successfully!');
    return SignUpResponse(null, 200);
  } else {
    debugPrint('Error submitting data.');
    return SignUpResponse(jsonDecode(response.body), response.statusCode);
  }
}

Future signIn(emailOrPhone, password, deviceID) async {
  final http.Response response =
      await http.post(Uri.parse('$baseUri${ApiConstants.signInEndpoint}'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "password": password,
            "phoneNumber": emailOrPhone,
            "email": emailOrPhone,
            "deviceID": deviceID
          }));
  if (response.statusCode == 200) {
    //print(Data.fromJson(json.decode(response.body)).email);
    return Data.fromJson(json.decode(response.body));
    //return json.decode(response.body);
  } else {
    throw Exception('Login Failed');
  }
}

Future logOut(id) async {
  final http.Response response = await http.post(
      Uri.parse('$baseUri${ApiConstants.logoutEndpoint}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"id": id}));
  if (response.statusCode == 200) {
    return 'logout success';
  } else {
    return 'logout failed';
  }
}
