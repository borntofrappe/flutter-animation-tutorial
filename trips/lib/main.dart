import 'package:flutter/material.dart';
import 'package:trips/screens/home.dart';
// import 'package:trips/screens/sandbox.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trips',
      home: Home()
    );
  }
}