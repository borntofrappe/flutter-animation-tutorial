import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  const Heart({ Key? key }) : super(key: key);

  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.favorite,
        color: Colors.grey[400],
        size: 30
      ),
      onPressed: () {}
    );
  }
}