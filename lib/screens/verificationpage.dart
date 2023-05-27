import 'package:flutter/material.dart';
import 'package:waya/colorscheme.dart';
import 'package:waya/screens/signup.dart';
import '../constants/design_constants.dart';

class VerificationPage extends StatefulWidget {
  final dynamic phoneNumber;

  const VerificationPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  TextEditingController verificationCode = TextEditingController();

  void _addDigit(String digit) {
    setState(() {
      verificationCode.text += digit;
    });
  }

  void _removeLastDigit() {
    setState(() {
      String currentText = verificationCode.text;
      if (currentText.isNotEmpty) {
        verificationCode.text = currentText.substring(0, currentText.length - 1);
      }
    });
  }

  @override
  void dispose() {
    verificationCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 25,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Icon(
                Icons.lock,
                size: 50,
                color: customPurple,
              ),

              SizedBox(height: 10),
              Text(
                'Verification',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: customPurple,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.phone,
                      color: customPurple,
                    ),
                    Text(
                      '${widget.phoneNumber}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: customPurple,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              TextField(
                readOnly: true,
                showCursor: false,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Verification Code',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                controller: verificationCode,
              ),
              SizedBox(height: 30),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 11,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 10) {
                      // Render the '0' button
                      return buildKeyboardButton('0');
                    } else if (index == 9) {
                      // Render the delete button
                      return buildDeleteButton();
                    } else {
                      // Render the digit buttons from 1 to 9
                      return buildKeyboardButton((index + 1).toString());
                    }
                  },
                ),
              ),
              SizedBox(height: 15),
        SizedBox(
          width: 250,
          height: 45,
          child:ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return SignUp(phoneNumber: widget.phoneNumber);
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: customPurple,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                        bottom: Radius.circular(20),
                      ),
                    )),
                child: Text(
                  'Verify',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
        ),  SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildKeyboardButton(String digit) {
    return InkWell(
      onTap: () => _addDigit(digit),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          digit,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: customPurple,
          ),
        ),
      ),
    );
  }

  Widget buildDeleteButton() {
    return InkWell(
      onTap: _removeLastDigit,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.backspace,
          size: 24,
          color: customPurple,
        ),
      ),
    );
  }
}
