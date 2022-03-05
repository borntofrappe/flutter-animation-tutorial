import 'package:flutter/material.dart';

class SandBox extends StatefulWidget {
  const SandBox({Key? key}) : super(key: key);

  @override
  State<SandBox> createState() => _SandBoxState();
}

class _SandBoxState extends State<SandBox> {
  double _opacity = 1;
  double _margin = 0;
  double _width = 200;
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedContainer(
            duration: const Duration(seconds: 1),
            margin: EdgeInsets.all(_margin),
            width: _width,
            color: _color,
            child: SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _margin = 50;
                        });
                      },
                      child: const Text('Animate margin'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _color = Colors.purple;
                        });
                      },
                      child: const Text('Animate color'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _width = 400;
                        });
                      },
                      child: const Text('Animate width'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _opacity = 0;
                        });
                      },
                      child: const Text('Animate opacity'),
                    ),
                    AnimatedOpacity(
                        duration: const Duration(seconds: 1),
                        opacity: _opacity,
                        child: const Text('Hide me',
                            style: TextStyle(color: Colors.white)))
                  ]),
            )));
  }
}
