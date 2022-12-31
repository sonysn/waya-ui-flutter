import 'package:flutter/material.dart';
import 'package:waya/screens/messagesnotificationpage.dart';

  class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
  }

  class _HistoryPageState extends State<HistoryPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const MessagesnotificationPage();
                      }));
                },

                ),
              Container(
                height: 45,
                decoration: const BoxDecoration(
                  //color: Colors.grey[300],
                  // border: Border(
                  //   bottom: BorderSide(width: 3.0, color: Colors.grey)
                  // ),
                ),
                child: SizedBox(
                  height: 80,
                  width: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Text('messagesnotification')],
                  ),
                ),
              ),],
              ),
            ));

  }
}
