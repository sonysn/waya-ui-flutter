import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qunot/constants/api_constants.dart';
import 'package:qunot/models/auth.dart';

//todo base uri value here
// var baseUri = 'http://192.168.100.43:3000';
// var baseUri = 'https://waya-api.onrender.com';
var baseUri = ApiConstants.baseUrl;

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

Future logOut({required int id, required String authBearer}) async {
  final http.Response response = await http.post(
      Uri.parse('$baseUri${ApiConstants.logoutEndpoint}'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": 'Bearer $authBearer'
      },
      body: jsonEncode({"id": id}));
  if (response.statusCode == 200) {
    return 'logout success';
  } else {
    return 'logout failed';
  }
}

Future changePassword(
    {required int id,
    required String newPassword,
    required String oldPassword,
    required String authBearer}) async {
  final http.Response response = await http.post(
    Uri.parse('$baseUri${ApiConstants.changePasswordEndpoint}'),
    headers: {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $authBearer'
    },
    body: jsonEncode(
        {"userId": id, "newPassword": newPassword, "oldPassword": oldPassword}),
  );
  return response;
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

/// Uploads a profile image for a user.
///
/// Parameters:
///   - userID: The ID of the user.
///   - profilePhoto: The file containing the profile photo.
///   - userToken: The token used for authorization.
///
/// Returns:
///   A Future that completes with the HTTP status code of the upload request.
Future<int> uploadProfileImage({
  required int userID,
  required File profilePhoto,
  required String userToken,
}) async {
  final formData = http.MultipartRequest(
    'POST',
    Uri.parse('$baseUri${ApiConstants.uploadProfileImageEndpoint}'),
  );

  formData.headers['Authorization'] = 'Bearer $userToken';
  formData.fields['userID'] = userID.toString();

  var profilePhotoFile = await http.MultipartFile.fromPath(
    'profilePhoto',
    profilePhoto.path,
  );

  formData.files.add(profilePhotoFile);

  http.StreamedResponse response;
  try {
    response = await formData.send();
  } catch (e) {
    print('Error sending form data: $e');
    rethrow;
  }

  return response.statusCode;
}
