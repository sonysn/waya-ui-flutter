import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:waya/api/payments.dart';

class TransferPage extends StatefulWidget {
  final dynamic phoneNumber;
  final String authToken;
  const TransferPage(
      {Key? key, required this.phoneNumber, required this.authToken})
      : super(key: key);

  @override
  TransferPageState createState() => TransferPageState();
}

class TransferPageState extends State<TransferPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _recipientController = TextEditingController();
  bool _transferToWho =
      true; // Indicates whether the transfer is to a driver or another user
  //true defaults to the driver

  void _checkWho() async {
    _recipientController.addListener(() {
      if (_recipientController.text.length > 12) {
        print(_recipientController.text);
      }
    });
  }

  void _transferFunds() async {
    // Perform the fund transfer logic here
    String amount = _amountController.text;
    String recipient = _recipientController.text;
    double? amountDouble;

    if (amount.isNotEmpty) {
      amountDouble = double.tryParse(amount);
    }

    // Validate the entered data
    if (amountDouble == null || recipient.isEmpty) {
      _showErrorSnackBar(
          'Please enter transfer amount and recipient phone number');
      return;
    }

    // Perform the transfer operation based on the transferToDriver value
    if (_transferToWho) {
      // Transfer to a driver
      // Perform the transfer logic for transferring to a driver
      final response = await transferToDrivers(
          amountToBeTransferred: amountDouble,
          driverPhoneNumber: recipient,
          userPhoneNumber: widget.phoneNumber,
          authBearer: widget.authToken);

      if (response.statusCode == 200) {
        var message = json.decode(response.body);
        _showSuccessSnackBar(message['message']);
      } else {
        var message = json.decode(response.body);
        _showErrorSnackBar(message['message']);
      }
    } else {
      // Transfer to another user
      // Perform the transfer logic for transferring to another user
      final response = await transferToUsers(
          amountToBeTransferred: amountDouble,
          userReceivingPhoneNumber: recipient,
          userSendingPhoneNumber: widget.phoneNumber,
          authBearer: widget.authToken);

      if (response.statusCode == 200) {
        var message = json.decode(response.body);
        _showSuccessSnackBar(message['message']);
      } else {
        var message = json.decode(response.body);
        _showErrorSnackBar(message['message']);
      }
    }

    // Show a success message
    //_showSuccessSnackBar('Funds transferred successfully');

    // Clear the input fields
    _amountController.clear();
    _recipientController.clear();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _checkWho();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _recipientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Transfer Funds',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              const Text(
                'Transfer Amount',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter transfer amount',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Recipient',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _recipientController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter recipient phone number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Transfer To:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Driver'),
                      leading: Radio(
                        activeColor: Colors.orangeAccent,
                        value: true,
                        groupValue: _transferToWho,
                        onChanged: (value) {
                          setState(() {
                            _transferToWho = value as bool;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('User'),
                      leading: Radio(
                        activeColor: Colors.orangeAccent,
                        value: false,
                        groupValue: _transferToWho,
                        onChanged: (value) {
                          setState(() {
                            _transferToWho = value as bool;
                          });
                          //debugPrint(_transferToWho.toString());
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: _transferFunds,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 32.0,
                    ),
                    child: Text(
                      'Transfer Funds',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
