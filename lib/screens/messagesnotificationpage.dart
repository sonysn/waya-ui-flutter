import 'package:flutter/material.dart';

    class MessagesnotificationPage extends StatefulWidget {
    const MessagesnotificationPage({Key? key}) : super(key: key);

    @override
    State<MessagesnotificationPage> createState() => _MessagesnotificationPageState();
    }

    class _MessagesnotificationPageState extends State<MessagesnotificationPage> {


    @override
    Widget build(BuildContext context) {
    return  Scaffold(
    body: Container(
    padding: const EdgeInsets.only(top: 40),
    margin: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    const Text(
    "Messages",
    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
    ),
    const SizedBox(
    height: 20,
    ),


                Container(
                    height: 70,
                    width: 350,

                    decoration: const BoxDecoration(
                        color: Colors.blue,
                         border: Border(
                          bottom: BorderSide(width: 3.0, color: Colors.grey)
                        ),
                    ),
            child: SizedBox(
                height: 70,
                width: 350,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                        Icon(Icons.discount_outlined,color: Colors.pink,
                            size: 40.0,),
                        Text('Discount 35% ', style: TextStyle(fontSize: 25),),
                        Text('Special promo only valid for new customers!', style: TextStyle(fontSize: 10),),


                    ],
                ),
            ),
        ),
        const SizedBox(
            height: 20,
        ),
        Container(
            height: 70,
            width: 350,

            decoration: const BoxDecoration(
                color: Colors.blue,
                border: Border(
                    bottom: BorderSide(width: 3.0, color: Colors.grey)
                ),
            ),
            child: SizedBox(
                height: 70,
                width: 350,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                        Icon(Icons.discount_outlined,color: Colors.pink,
                            size: 40.0,),
                        Text('Discount 35% ', style: TextStyle(fontSize: 25),),
                        Text('Special promo only valid for new customers!', style: TextStyle(fontSize: 10),),


                    ],
                ),
            ),
        ),
        const SizedBox(
            height: 20,
        ),
        Container(
            height: 70,
            width: 350,
            decoration:  BoxDecoration(
                color: Colors.blue,
                border: Border.all(width: 10),
                borderRadius: BorderRadius.circular(10,)
                ),

            child: SizedBox(
                height: 70,
                width: 350,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                        Icon(Icons.discount_outlined,color: Colors.pink,
                            size: 40.0,),
                        Text('Discount 35% ', style: TextStyle(fontSize: 25),),
                        Text('Special promo only valid for new customers!', style: TextStyle(fontSize: 10),),


                    ],
                ),
            ),
        ),
      ]),

    )

    );


    }
    }