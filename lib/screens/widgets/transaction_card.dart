import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatefulWidget {
  final dynamic data;
  final double depositAmount;
  final dynamic depositDate;
  const TransactionCard(
      {Key? key, this.data, required this.depositAmount, this.depositDate})
      : super(key: key);

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  void formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    setState(() {
      depositDateFormatted = formatter.format(date);
    });
  }

  String? depositDateFormatted;

  @override
  void initState() {
    super.initState();
    formatDate(widget.depositDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: widget.data.profilePhoto != "null"
                    ? ClipOval(
                        child: Image.network(
                          '${widget.data.profilePhoto}',
                          fit: BoxFit.cover,
                          width: 50.0,
                          height: 50.0,
                        ),
                      )
                    : const Icon(
                        Icons.account_circle,
                        size: 50.0,
                        color: Colors.black,
                      ),
              ),
              const SizedBox(
                width: 5,
              ),
              const Icon(
                Icons.add_box_rounded,
                color: Colors.green,
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "₦${widget.depositAmount.toString()}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    depositDateFormatted!,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
