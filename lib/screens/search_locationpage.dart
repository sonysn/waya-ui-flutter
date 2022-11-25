import 'package:flutter/material.dart';

import '../colorscheme.dart';

class SearchLocationPage extends StatefulWidget {
  const SearchLocationPage({Key? key}) : super(key: key);

  @override
  State<SearchLocationPage> createState() => _SearchLocationPageState();
}

class _SearchLocationPageState extends State<SearchLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(top: 40),
                margin: const EdgeInsets.symmetric(horizontal: 17),
                child: Column(
                  children: [
                    //TextField for name
                    TextField(
                      onTap: (){},
                      //controller: firstname,
                      cursorColor: customPurple,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          hintText: 'Search here',
                          contentPadding: EdgeInsets.all(15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(25)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(25)),
                            borderSide: BorderSide(color: customPurple),
                          )),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
