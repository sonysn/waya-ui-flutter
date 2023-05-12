import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../models/auth.dart';

//todo base uri value here
// var baseUri = 'http://192.168.100.43:3000';
var baseUri = 'https://waya-api.onrender.com';

Future signIn(emailOrPhone, password, deviceID) async {
  final http.Response response = await http.post(
      Uri.parse('$baseUri${ApiConstants.signInEndpoint}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "password": password,
        "phoneNumber": emailOrPhone,
        "email": emailOrPhone,
        "deviceID": deviceID
      }));
  if(response.statusCode == 200){
    //print(Data.fromJson(json.decode(response.body)).email);
    return Data.fromJson(json.decode(response.body));
    //return json.decode(response.body);
  } else {
    throw Exception('Login Failed');
  }
}

Future logOut(id) async{
  final http.Response response = await http.post(
      Uri.parse('$baseUri${ApiConstants.logoutEndpoint}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id": id
      })
  );
  if(response.statusCode == 200){
    return 'logout success';
  } else {
    return 'logout failed';
  }
}