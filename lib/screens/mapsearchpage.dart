import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DestinationPage extends StatefulWidget {
  const DestinationPage({Key? key}) : super(key: key);

  @override
  _DestinationPageState createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  TextEditingController _destinationController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            child: SvgPicture.asset(
              'assets/icons/share.svg',
              height: 24.0,
              color: Colors.black, // Set icon color to black
            ),
          ),
        ),
        title: Center(
          child: const Text(
            'Set Location',
            style: TextStyle(
              color: Colors.black, // Set app bar text color to black
            ),
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            child: SvgPicture.asset(
              'assets/icons/cancel.svg',
              height: 24.0,
              color: Colors.black, // Set icon color to white
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Form(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (text) {},
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Location',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: SvgPicture.asset(
                          'assets/icons/location.svg',
                          color: Colors.black, // Set icon color to black
                          height: 24.0,
                        ),
                      ),
                      fillColor: Colors.grey[150], // Set light grey background
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0), // Add spacing between the text fields
                  TextFormField(
                    onChanged: (text) {},
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: 'Enter destination',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: SvgPicture.asset(
                          'assets/icons/location_icon.svg',
                          color: Colors.black, // Set icon color to black
                          height: 24.0,
                        ),
                      ),
                      fillColor: Colors.grey[150], // Set light grey background
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 4.0,
                    thickness: 4.0,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: double.infinity, // Expand width to the end
                      decoration: BoxDecoration(
                        color: Colors.grey[300], // Set light grey background
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/icons/share.svg',
                          color: Colors.black, // Set icon color to black
                          height: 24.0,
                        ),
                        label: const Text(
                          'Use My Current Location',
                          style: TextStyle(
                            fontSize: 16.0, // Set font size to 16
                            fontWeight: FontWeight.bold, // Set font weight to bold
                            color: Colors.black, // Set text color to black
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            height: 4.0,
            thickness: 4.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
