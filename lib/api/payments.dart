import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:waya/constants/api_constants.dart';

//todo base uri value here
//var baseUri = 'http://192.168.100.43:3000';
var baseUri = 'https://waya-api.onrender.com';
// var baseUri = 'https://789d-102-216-201-31.ngrok-free.app';

Future paystackDeposit(
    {required int id,
    required dynamic phone,
    required String email,
    required int amount,
    required String authBearer}) async {
  try {
    final http.Response response = await http.post(
      Uri.parse('$baseUri${ApiConstants.chargeEndpoint}'),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": 'Bearer $authBearer'
      },
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

Future transferToDrivers(
    {required double amountToBeTransferred,
    required String driverPhoneNumber,
    required String userPhoneNumber,
    required String authBearer}) async {
  try {
    final http.Response response = await http.post(
        Uri.parse('$baseUri${ApiConstants.transferToDriversEndpoint}'),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $authBearer'
        },
        body: jsonEncode({
          'amountToBeTransferred': amountToBeTransferred,
          'driverPhoneNumber': driverPhoneNumber,
          'userPhoneNumber': userPhoneNumber
        }));
    return response;
  } catch (e) {
    throw Exception('An error occurred while processing your transfer.');
  }
}

Future transferToUsers(
    {required double amountToBeTransferred,
    required String userReceivingPhoneNumber,
    required String userSendingPhoneNumber,
    required String authBearer}) async {
  try {
    final http.Response response = await http.post(
        Uri.parse('$baseUri${ApiConstants.transferToUsersEndpoint}'),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $authBearer'
        },
        body: jsonEncode({
          'amountToBeTransferred': amountToBeTransferred,
          'userReceivingPhoneNumber': userReceivingPhoneNumber,
          'userSendingPhoneNumber': userSendingPhoneNumber
        }));
    return response;
  } catch (e) {
    throw Exception('An error occurred while processing your transfer.');
  }
}

Future getRiderPaystackDepositTransactions(
    {required int userID, required String authBearer}) async {
  try {
    final http.Response response = await http.get(
        Uri.parse(
            '$baseUri/$userID${ApiConstants.getRiderPaystackDepositTransactions}'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $authBearer'
        });
    return json.decode(response.body);
  } catch (e) {
    throw Exception('An error occurred');
  }
}

Future getUserToUserTransactions(
    {required int userID, required String authBearer}) async {
  try {
    final http.Response response = await http.get(
        Uri.parse('$baseUri/$userID${ApiConstants.getUserToUserTransactions}'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $authBearer'
        });
    return jsonEncode(response.body);
  } catch (e) {
    throw Exception('An error occurred');
  }
}

Future getUserToDriverTransactions(
    {required int userID, required String authBearer}) async {
  try {
    final http.Response response = await http.get(
        Uri.parse(
            '$baseUri/$userID${ApiConstants.getUserToDriverTransactions}'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $authBearer'
        });
    return json.decode(response.body);
  } catch (e) {
    throw Exception('An error occurred');
  }
}

Future getUserToUserTransactionsForReceiver(
    {required int userID, required String authBearer}) async {
  try {
    final http.Response response = await http.get(
        Uri.parse(
            '$baseUri/$userID${ApiConstants.getUserToUserTransactionsForReceiver}'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $authBearer'
        });
    return json.decode(response.body);
  } catch (e) {
    throw Exception('An error occurred');
  }
}

Future getDepositHistory(
    {required int userID, required String authBearer}) async {
  try {
    final http.Response response = await http.get(
        Uri.parse(
            '$baseUri/$userID${ApiConstants.getRiderPaystackDepositTransactions}'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $authBearer'
        });
    return json.decode(response.body);
  } catch (e) {
    throw Exception('An error occurred');
  }
}
