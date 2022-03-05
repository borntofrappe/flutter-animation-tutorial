import 'package:flutter/material.dart';
import 'package:trips/models/Trip.dart';
import 'package:trips/screens/details.dart';

class TripList extends StatefulWidget {
  const TripList({ Key? key }) : super(key: key);

  @override
  State<TripList> createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final Tween<Offset> _offset = Tween(begin: const Offset(-1, 0), end: const Offset(0, 0));
  
  List<Widget> _tripTiles = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _addTrips();
    });
  }

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
        child: Hero(
          tag: 'location-img-${trip.img}',
          child: Image.asset(
            'images/${trip.img}',
            height: 50.0
          ),
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

    Future ft = Future(() {});

    for (Trip trip in _trips) {
      ft = ft.then((_) {
        return Future.delayed(const Duration(milliseconds: 200), () {

        _tripTiles.add(_buildTile(trip));
        _listKey.currentState?.insertItem(_tripTiles.length - 1);
        });
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: _tripTiles.length,
      itemBuilder: (context, i, animation) {
        return SlideTransition(
          child: _tripTiles[i],
          position: animation.drive(_offset)
        );
      }
    );
  }
}