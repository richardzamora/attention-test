import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class PointElement extends StatefulWidget {
  final bool eternal;
  const PointElement({Key? key, this.eternal = false}) : super(key: key);

  @override
  State<PointElement> createState() => _PointElementState();
}

class _PointElementState extends State<PointElement> {
  late int limitTime;
  final random = Random();
  bool showElement = true;
  AnimationController? animationController;

  @override
  void initState() {
    if (!widget.eternal) {
      //TODO max animation time
      limitTime = random.nextInt(118) + 2;
      Future.delayed(Duration(seconds: limitTime), () {
        if (mounted) {
          setState(() {
            animationController?.stop();
            showElement = false;
          });
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double size = random.nextInt(50) + 5;
    return showElement
        ? Flash(
            controller: (controller) {
              animationController = controller;
            },
            //TODO animation speed
            duration: Duration(milliseconds: random.nextInt(5000) + 100),
            infinite: true,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)),
            ),
          )
        : Container();
  }
}
