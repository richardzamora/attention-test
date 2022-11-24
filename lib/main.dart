import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:test_attention/widgets/counter_widget.dart';
import 'package:test_attention/widgets/point_element.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final random = Random();
  List<Widget> elements = [];
  Widget initialWidget = Container();
  Widget countDown = Container();

  bool showButton = true;
  bool isAnimating = false;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    final minWidth = MediaQuery.of(context).size.width * 0.05;
    final maxWidth = MediaQuery.of(context).size.width * 0.9;
    final minHeight = MediaQuery.of(context).size.height * 0.05;
    final maxHeight = MediaQuery.of(context).size.height * 0.85;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [initialWidget, ...elements, Center(child: countDown)],
      ),
      floatingActionButton: showButton
          ? FloatingActionButton(
              backgroundColor: Colors.blueGrey,
              onPressed: () {
                _startAnimation(minWidth, maxWidth, minHeight, maxHeight);
              },
              child: Text(isAnimating ? "Stop" : "Start"))
          : null,
    );
  }

  void _startAnimation(
      double minWidth, double maxWidth, double minHeight, double maxHeight) {
    if (isAnimating) {
      isAnimating = false;
      timer?.cancel();
      int time = 5;
      countDown = CounterWidget(time: time);
      showButton = false;
      setState(() {});
      Timer counter = Timer.periodic(Duration(seconds: 1), (timer) {
        time--;
        countDown = CounterWidget(time: time);
        setState(() {});
      });
      Future.delayed(Duration(seconds: 5)).then((value) {
        elements = [];
        counter.cancel();
        countDown = Container();
        showButton = true;
        setState(() {});
      });
    } else {
      showButton = false;
      isAnimating = true;
      initialWidget = Positioned(
          top: random.nextInt(maxHeight.toInt()) + minHeight,
          left: random.nextInt(maxWidth.toInt()) + minWidth,
          child: const PointElement(
            eternal: true,
          ));
      //TODO: tiempo para que inicie la animación
      Future.delayed(const Duration(seconds: 3), () {
        timer = Timer.periodic(const Duration(seconds: 2), (timer) {
          Future.delayed(Duration(milliseconds: random.nextInt(400)))
              .then((value) {
            elements.add(Positioned(
                top: random.nextInt(maxHeight.toInt()) + minHeight,
                left: random.nextInt(maxWidth.toInt()) + minWidth,
                child: const PointElement()));
            setState(() {});
          });
        });
      });
      //TODO: Duración para que aparezca el botón
      Future.delayed(const Duration(seconds: 10), () {
        showButton = true;
        setState(() {});
      });
      setState(() {});
    }
  }
}
