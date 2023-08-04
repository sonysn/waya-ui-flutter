import 'package:flutter/material.dart';
import 'package:qunot/colorscheme.dart';
import 'package:qunot/screens/newpassword.dart';

class ResetPasswordCodePage extends StatefulWidget {
  final String emailorPhone;
  const ResetPasswordCodePage({Key? key, required this.emailorPhone})
      : super(key: key);

  @override
  State<ResetPasswordCodePage> createState() => _ResetPasswordCodePageState();
}

class _ResetPasswordCodePageState extends State<ResetPasswordCodePage> {
  List<String> code = List.filled(4, '');

  void updateCode(int index, String digit) {
    setState(() {
      code[index] = digit;
    });
  }

  void deleteCode(int index) {
    if (index > 0) {
      setState(() {
        code[index] = '';
      });
    }
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
                icon: const Icon(
                  Icons.arrow_back,
                  size: 25,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Icon(
                Icons.lock,
                size: 50,
                color: customPurple,
              ),
              const SizedBox(height: 10),
              const Text(
                'Enter Code',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: customPurple,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => VerificationCodeBox(
                    value: code[index],
                    onDigitEntered: (digit) => updateCode(index, digit),
                    onDeletePressed: () => deleteCode(index),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
              const SizedBox(height: 10),
              SizedBox(
                width: 250,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the forgot password page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return NewPasswordPage(
                              code: code.join(),
                              emailorPhone: widget.emailorPhone);
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
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildKeyboardButton(String digit) {
    return InkWell(
      onTap: () => updateCodeWithDigit(digit),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          digit,
          style: const TextStyle(
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
      onTap: deleteLastDigit,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.backspace,
          size: 24,
          color: customPurple,
        ),
      ),
    );
  }

  void updateCodeWithDigit(String digit) {
    for (int i = 0; i < code.length; i++) {
      if (code[i].isEmpty) {
        updateCode(i, digit);
        break;
      }
    }
  }

  void deleteLastDigit() {
    for (int i = code.length - 1; i >= 0; i--) {
      if (code[i].isNotEmpty) {
        setState(() {
          code[i] = '';
        });
        break;
      }
    }
  }
}

class VerificationCodeBox extends StatelessWidget {
  final String value;
  final ValueChanged<String> onDigitEntered;
  final VoidCallback onDeletePressed;

  const VerificationCodeBox({
    super.key,
    required this.value,
    required this.onDigitEntered,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                value.isEmpty ? '' : '●',
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
