import 'package:flutter/material.dart';

class MessagesNotificationPage extends StatefulWidget {
  const MessagesNotificationPage({Key? key}) : super(key: key);

  @override
  State<MessagesNotificationPage> createState() =>
      _MessagesNotificationPageState();
}

class _MessagesNotificationPageState extends State<MessagesNotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 40),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Notifications",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Container(
                height: 70,
                //width: 350,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: SizedBox(
                  height: 70,
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.info,
                        size: 25.0,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Message Head',
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(
                            'Special promo only valid for new customers!',
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ]),
        ));
  }
}