import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);




  Widget build(BuildContext context) { List<Map<String, dynamic>>
  trips = [    {      'pickupLocation': 'New York City',      'dropoffLocation': 'Boston',      'driverName': 'John Smith',      'driverRating': 4.5,      'tripDate': 'Jan 1, 2021',    },    {      'pickupLocation': 'Los Angeles',      'dropoffLocation': 'San Francisco',      'driverName': 'Jane Doe',      'driverRating': 4.0,      'tripDate': 'Feb 15, 2021',    },    {      'pickupLocation': 'Miami',      'dropoffLocation': 'Orlando',      'driverName': 'Bob Johnson',      'driverRating': 3.5,      'tripDate': 'Mar 10, 2021',    },  ];

  return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: ListView.builder(
        itemCount: trips.length,
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic> trip = trips[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pickup: ${trip['pickupLocation']}',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Dropoff: ${trip['dropoffLocation']}',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Driver: ${trip['driverName']} (${trip['driverRating']} stars)',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  Text(
                    'Date: ${trip['tripDate']}',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
