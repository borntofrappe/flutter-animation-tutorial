import 'package:flutter/material.dart';
import 'package:trips/models/Trip.dart';
import 'package:trips/shared/Heart.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class Details extends StatelessWidget {
  final Trip trip;
  
  const Details({
    required this.trip,   
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              child: Image.asset(
                'images/${trip.img}',
                height: 360,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              )
            ),
            const SizedBox(height: 30),
            ListTile(
              title: Text(
                trip.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey[800]
                )
              ),
              subtitle: Text(
                '${trip.nights} night stay for only \$${trip.price}',
                style: const TextStyle(letterSpacing: 1.0)
              ),
              trailing: Heart()
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                lorem(paragraphs: 1, words: 50),
                style: TextStyle(
                  color: Colors.grey[600],
                  height: 1.4
                )
              )
            )
          ]
        )
      )
    );
  }
}

