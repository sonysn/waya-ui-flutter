import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:waya/constants/api_constants.dart';

//todo base uri value here
//var baseUri = 'http://192.168.100.43:3000';
var baseUri = 'https://waya-api.onrender.com';
// var baseUri = 'https://789d-102-216-201-31.ngrok-free.app';

Future paystackDeposit({required int id,required dynamic phone,required String email, required int amount}) async {
  try {
    final http.Response response = await http.post(
      Uri.parse('$baseUri${ApiConstants.chargeEndpoint}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userID': id,
        'phone': phone,
        'email': email,
        'amount': amount,
        'reference': 'ref_${DateTime.now().millisecondsSinceEpoch}',
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('An error occurred while processing your payment.');
    }
  } catch (e) {
    throw Exception('An error occurred while processing your payment.');
  }
}