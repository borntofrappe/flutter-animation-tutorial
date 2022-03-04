import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  const Heart({ Key? key }) : super(key: key);

  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> with TickerProviderStateMixin {
  bool isFavorite = false;
  late AnimationController _controller;
  late Animation _colorAnimation;
  late Animation _sizeAnimation;
  late Animation<double> _curve;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this
    );

    _curve = CurvedAnimation(parent: _controller, curve: Curves.slowMiddle);

    _colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red).animate(_curve);
    _sizeAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(tween: Tween(begin: 1, end: 1.5), weight: 50),
        TweenSequenceItem<double>(tween: Tween(begin: 1.5, end: 1), weight: 50),
      ]
    ).animate(_curve);

    // _controller?.forward();

    // _controller?.addListener(() {
    //   setState(() {});
    // });

    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        setState(() {
          isFavorite = true;
        });
      } else if(status == AnimationStatus.dismissed) {
        setState(() {
          isFavorite = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        return Transform.scale(
          scale: _sizeAnimation.value,
          child: IconButton(
            icon: Icon(
              Icons.favorite,
              color: _colorAnimation.value,
              size: 30
            ),
            onPressed: () {
              if(isFavorite) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
            }
          ),
        );
      }
    );
  }
}