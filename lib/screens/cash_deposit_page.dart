import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:waya/api/payments.dart';
import 'package:waya/screens/paystack_deposit_webview.dart';

class CashDepositPage extends StatefulWidget {
  final int id;
  final dynamic phone;
  final String email;
  const CashDepositPage(
      {Key? key, required this.email, required this.id, this.phone})
      : super(key: key);

  @override
  State<CashDepositPage> createState() => _CashDepositPageState();
}

class _CashDepositPageState extends State<CashDepositPage> {
  bool _isLoading = false;
  String? _authorizationUrl;

  final TextEditingController _cashDepositController = TextEditingController();

  @override
  void dispose() {
    _cashDepositController.dispose();
    super.dispose();
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void _navigateToDepositWebView(authorizationUrl) {
    navigatorKey.currentState?.push(MaterialPageRoute(
      builder: (context) => DepositWebView(authorizationUrl: authorizationUrl),
    ));
  }

  Future<void> _handleDeposit() async {
    final email = widget.email;
    final phone = widget.phone;
    final userID = widget.id;
    final amount = _cashDepositController.text;
    setState(() {
      _isLoading = true;
    });
    //paystack code eg 200 naira is 20000
    try {
      final response = await await paystackDeposit(
          email: email,
          amount: int.parse('${_removeComma(amount)}00'),
          id: userID,
          phone: phone);
      setState(() {
        _authorizationUrl = response['authorization_url'];
        _isLoading = false;
      });
      // Open the authorization URL in a webview to complete the payment
      //_navigateToDepositWebView(_authorizationUrl);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DepositWebView(
            authorizationUrl: _authorizationUrl,
          ),
        ),
      );
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('An error occurred while processing your payment.')),
      );
    }
  }

  void _deleteLastCharacter() {
    final text = _cashDepositController.text;
    if (text.isNotEmpty) {
      final newText = text.substring(0, text.length - 1);
      _cashDepositController.text = newText;
      _cashDepositController.selection =
          TextSelection.fromPosition(TextPosition(offset: newText.length));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Set the background color to black
        title: const Text('Deposit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16.0),
//GIT TEST//
            TextFormField(
              controller: _cashDepositController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: Colors.black, // Set text color to black
              ),
              cursorColor: Colors.black, // Set cursor color to black
              decoration: InputDecoration(
                labelText: 'Deposit Amount',
                labelStyle: TextStyle(
                  color: Colors.black, // Set label color to black
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black, // Set border color to black when focused
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black, // Set border color to black
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an amount';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _handleDeposit();
                // Handle deposit button press
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                textStyle: const TextStyle(fontSize: 20.0),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text('Deposit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberButton(String label) {
    return ElevatedButton(
      onPressed: () {
        final text = _cashDepositController.text;
        final newText = _formatNumber(_tryParseInt(_removeComma(text + label)));
        _cashDepositController.text = newText;
        _cashDepositController.selection =
            TextSelection.fromPosition(TextPosition(offset: newText.length));
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(60.0)),
        ),
      ),
      child: Text(label),
    );
  }

  String _formatNumber(int number) {
    final formatter = NumberFormat("#,###,###,###");
    return formatter.format(number);
  }

  String _removeComma(String text) {
    return text.replaceAll(',', '');
  }

  int _tryParseInt(String value) {
    try {
      final intValue = int.parse(value);
      if (intValue > 1000000000) {
        throw Exception('Value exceeds maximum limit');
      }
      return intValue;
    } catch (e) {
      print('Error: $e');
      return 0;
    }
  }
}
