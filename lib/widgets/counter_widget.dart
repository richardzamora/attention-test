import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    Key? key,
    required this.time,
  }) : super(key: key);

  final int time;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100), color: Colors.blueGrey),
      child: Center(
        child: Text(
          "$time",
          style: const TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }
}
