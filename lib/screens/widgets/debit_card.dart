import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DebitCard extends StatefulWidget {
  final dynamic data;
  final dynamic amountTransferred;
  final dynamic dateTransferred;
  const DebitCard(
      {Key? key,
      this.data,
      required this.amountTransferred,
      required this.dateTransferred})
      : super(key: key);

  @override
  State<DebitCard> createState() => _DebitCardState();
}

class _DebitCardState extends State<DebitCard> {
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.withOpacity(0.2),
                    ),
                    child: const Icon(
                      Icons.arrow_circle_down,
                      color: Colors.green,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Received",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "₦${widget.amountTransferred.toString()}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withOpacity(0.2),
                    ),
                    child: const Icon(
                      Icons.calendar_today,
                      color: Colors.blue,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Date Transferred",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                depositTransferredFormatted!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
