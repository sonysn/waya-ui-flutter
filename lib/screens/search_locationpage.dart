import 'package:flutter/material.dart';
import 'package:qunot/constants/mapbox_constant.dart';
import 'package:qunot/colorscheme.dart';
import 'package:mapbox_search/mapbox_search.dart';

class SearchLocationPage extends StatefulWidget {
  const SearchLocationPage({Key? key}) : super(key: key);

  @override
  State<SearchLocationPage> createState() => _SearchLocationPageState();
}

class _SearchLocationPageState extends State<SearchLocationPage> {
  var placesSearch =
      PlacesSearch(apiKey: AppConstants.mapBoxAccessToken, limit: 5);

  void getPlaces() async {
    var f = await placesSearch.getPlaces("nnamdi azikwe international airport");
    print(f);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(top: 40),
              margin: const EdgeInsets.symmetric(horizontal: 17),
              child: Column(
                children: [
                  //TextField for name
                  TextField(
                    onTap: () {
                      getPlaces();
                    },
                    //controller: firstname,
                    cursorColor: customPurple,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        hintText: 'Search here',
                        contentPadding: EdgeInsets.all(15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          borderSide: BorderSide(color: customPurple),
                        )),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
