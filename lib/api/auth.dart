import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:waya/constants/api_constants.dart';
import 'package:waya/models/auth.dart';

//todo base uri value here
// var baseUri = 'http://192.168.100.43:3000';
var baseUri = 'https://waya-api.onrender.com';

class SignUpResponse {
  final Data? data;
  final int? statusCode;
  final dynamic body;

  SignUpResponse(this.data, this.statusCode, this.body);
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
    return SignUpResponse(null, 200, null);
  } else {
    debugPrint('Error submitting data.');
    return SignUpResponse(null, response.statusCode, jsonDecode(response.body));
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
    //return Data.fromJson(json.decode(response.body));
    final data = Data.fromJson(json.decode(response.body));
    return SignUpResponse(data, response.statusCode, null);
    //return json.decode(response.body);
  } else {
    return SignUpResponse(null, response.statusCode, jsonDecode(response.body));
    //throw Exception('Login Failed');
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

Future forgotPassword({required String emailOrphoneNumber}) async {
  final http.Response response = await http.post(
    Uri.parse('$baseUri${ApiConstants.forgotPasswordEndpoint}'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(
        {"email": emailOrphoneNumber, "phoneNumber": emailOrphoneNumber}),
  );
  return response;
}

Future changePassword(
    {required int id,
    required String newPassword,
    required String oldPassword}) async {
  final http.Response response = await http.post(
    Uri.parse('$baseUri${ApiConstants.changePasswordEndpoint}'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(
        {"userId": id, "newPassword": newPassword, "oldPassword": oldPassword}),
  );
  return response;
}

Future resetPasswordFromForgotPassword(
    {required String emailOrphoneNumber,
    required String userToken,
    required String newPassword}) async {
  final http.Response response = await http.post(
    Uri.parse('$baseUri${ApiConstants.verifyForgotPasswordChangeEndpoint}'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "email": emailOrphoneNumber,
      "phoneNumber": emailOrphoneNumber,
      "userToken": userToken,
      "newPassword": newPassword
    }),
  );
  return response;
}
