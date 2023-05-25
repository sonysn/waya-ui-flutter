import 'package:flutter/material.dart';

class TransferPage extends StatefulWidget {
  final dynamic phoneNumber;

  const TransferPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _recipientController = TextEditingController();
  bool _transferToDriver = false; // Indicates whether the transfer is to a driver or another user

  void _transferFunds() {
    // Perform the fund transfer logic here
    String amount = _amountController.text;
    String recipient = _recipientController.text;

    // Validate the entered data
    if (amount.isEmpty || recipient.isEmpty) {
      _showErrorSnackBar('Please enter transfer amount and recipient phone number');
      return;
    }

    // Perform the transfer operation based on the transferToDriver value
    if (_transferToDriver) {
      // Transfer to a driver
      // Perform the transfer logic for transferring to a driver
    } else {
      // Transfer to another user
      // Perform the transfer logic for transferring to another user
    }

    // Show a success message
    _showSuccessSnackBar('Funds transferred successfully');

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
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Transfer Funds',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              Text(
                'Transfer Amount',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
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
              SizedBox(height: 16.0),
              Text(
                'Recipient',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
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
              SizedBox(height: 16.0),
              Text(
                'Transfer To:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text('Driver'),
                      leading: Radio(
                        value: true,
                        groupValue: _transferToDriver,
                        onChanged: (value) {
                          setState(() {
                            _transferToDriver = value as bool;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('User'),
                      leading: Radio(
                        value: false,
                        groupValue: _transferToDriver,
                        onChanged: (value) {
                          setState(() {
                            _transferToDriver = value as bool;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: _transferFunds,
                  child: Padding(
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
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
