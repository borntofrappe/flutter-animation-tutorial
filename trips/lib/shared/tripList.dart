import 'package:flutter/material.dart';
import 'package:trips/models/Trip.dart';
import 'package:trips/screens/details.dart';

class TripList extends StatefulWidget {
  const TripList({ Key? key }) : super(key: key);

  @override
  State<TripList> createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  final GlobalKey _listKey = GlobalKey();

  List<Widget> _tripTiles = [];

  Widget _buildTile(Trip trip) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(trip: trip)
          )
        );
      },
      contentPadding: const EdgeInsets.all(24),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${trip.nights} nights',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blue[300]
            )
          ),
          Text(
            trip.title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600]
            )
          ),
        ]
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          'images/${trip.img}',
          height: 50.0
        )
      ),
      trailing: Text('\$${trip.price}')
    );
  }


  void _addTrips() {
    List<Trip> _trips = [
      Trip(title: 'Beach Paradise', price: '350', nights: '3', img: 'beach.png'),
      Trip(title: 'City Break', price: '400', nights: '5', img: 'city.png'),
      Trip(title: 'Ski Adventure', price: '750', nights: '2', img: 'ski.png'),
      Trip(title: 'Space Blast', price: '600', nights: '4', img: 'space.png'),
    ];

    for (Trip trip in _trips) {
      _tripTiles.add(_buildTile(trip));
    }
  }


  @override
  void initState() {
    super.initState();
    _addTrips();
  }


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: _listKey,
      itemCount: _tripTiles.length,
      itemBuilder: (_, i) => _tripTiles[i]
    );
  }
}