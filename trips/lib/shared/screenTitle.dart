import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String text;

  const ScreenTitle({ 
    required this.text, 
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 36,
          color: Colors.white,
          fontWeight: FontWeight.bold
        )
      ),
      duration: const Duration(milliseconds: 500),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeIn,
      builder: (BuildContext context, double _tweenedValue, Widget? child) {
          return Opacity(
            opacity: _tweenedValue,
            child: Padding(
              padding: EdgeInsets.fromLTRB(_tweenedValue * 20, 20, 0, 0),
              child: child
            ),
          );
      },
    );
  }
}