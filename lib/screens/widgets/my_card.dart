import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qunot/colorscheme.dart';

class MyCard extends StatefulWidget {
  final dynamic data;
  final Stream<String>? stream;

  const MyCard({Key? key, this.stream, this.data}) : super(key: key);

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  dynamic accountBalance;

  @override
  void initState() {
    super.initState();
    accountBalance = "${widget.data.accountBalance}";
    // This code listens to the stream of account balance changes, and updates the UI accordingly.
    // If the event is a string, it checks whether it can be parsed as an int or a double, and formats it accordingly with commas or decimals.
    // Otherwise, it sets the account balance to the event string as
    widget.stream?.listen((event) {
      // ignore: unnecessary_type_check
      if (event is String) {
        if (int.tryParse(event) != null) {
          setState(() {
            accountBalance = NumberFormat('#,##0').format(int.parse(event));
          });
        } else if (double.tryParse(event) != null) {
          setState(() {
            accountBalance = double.parse(event)
                .toStringAsFixed(2)
                .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                    (Match m) => '${m[1]},');
          });
        } else {
          setState(() {
            accountBalance = event;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          padding: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width * 0.88,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            color: customPurple,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.data.firstName} ${widget.data.lastName}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("YOUR BALANCE",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white)),
                      Text("₦$accountBalance",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: Colors.white)),
                    ],
                  ),
                  const SizedBox(width: 70),
                ],
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              )
            ],
          ),
        );
      },
    );
  }
}
