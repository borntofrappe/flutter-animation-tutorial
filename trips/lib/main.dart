import 'package:flutter/material.dart';
import 'package:trips/screens/home.dart';
// import 'package:trips/screens/sandbox.dart';
// import 'package:trips/screens/animatedListSample.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Trips',
      home: Home()
    );
  }
}