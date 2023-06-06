import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EarningCard extends StatefulWidget {
  final dynamic data;
  final dynamic amountTransferred;
  final dynamic dateTransferred;
  const EarningCard(
      {Key? key,
      this.data,
      required this.amountTransferred,
      required this.dateTransferred})
      : super(key: key);

  @override
  State<EarningCard> createState() => _EarningCardState();
}

class _EarningCardState extends State<EarningCard> {
  void formatDate(String dateString) {
    DateFormat originalFormat = DateFormat('dd-M-yyyy');
    DateFormat targetFormat = DateFormat('dd-MM-yyyy');
    DateTime date = originalFormat.parse(dateString);
    setState(() {
      depositTransferredFormatted = targetFormat.format(date);
    });
  }

  String? depositTransferredFormatted;

  @override
  void initState() {
    super.initState();

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
                    "₦${widget.amountTransferred.toString()}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    depositTransferredFormatted!,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "transaction.balance",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
