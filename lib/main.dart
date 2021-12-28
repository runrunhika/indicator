import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CustomProgressIndicator(),
    );
  }
}

class CustomProgressIndicator extends StatefulWidget {
  @override
  _CustomProgressIndicatorState createState() =>
      _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator> {
  late double _height;
  late double _width;

  double percent = 0.0;

  @override
  void initState() {
    Timer? timer;
    timer = Timer.periodic(Duration(milliseconds: 1000), (_) {
      setState(() {
        percent += 5;
        if (percent >= 100) {
          timer!.cancel();
          // percent=0;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Liquid Progress Bar",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                //Version 1
                Container(
                  height: 130,
                  width: 130,
                  child: LiquidCircularProgressIndicator(
                    value: percent / 100,
                    // Defaults to 0.5.
                    valueColor: AlwaysStoppedAnimation(Colors.purple),
                    backgroundColor: Colors.white,
                    borderColor: Colors.red,
                    borderWidth: 4.0,
                    direction: Axis.vertical,
                    center: Text(
                      percent.toString() + "%",
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                //Version 2
                Container(
                  height: 40,
                  child: LiquidLinearProgressIndicator(
                    value: percent / 100,
                    valueColor: AlwaysStoppedAnimation(Colors.pink),
                    backgroundColor: Colors.white,
                    borderColor: Colors.red,
                    borderWidth: 5.0,
                    borderRadius: 12.0,
                    direction: Axis.horizontal,
                    center: Text(
                      percent.toString() + "%",
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                //Version 3
                Container(
                    padding: EdgeInsets.all(10),
                    child: CircularPercentIndicator(
                      radius: 120.0,
                      lineWidth: 10.0,
                      animation: true,
                      percent: percent / 100,
                      center: Text(
                        percent.toString() + "%",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      backgroundColor: Colors.blue,
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.redAccent,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Path _buildBoatPath() {
    return Path()
      ..moveTo(15, 120)
      ..lineTo(0, 85)
      ..lineTo(50, 85)
      ..lineTo(60, 80)
      ..lineTo(60, 85)
      ..lineTo(120, 85)
      ..lineTo(105, 120) //and back to the origin, could not be necessary #1
      ..close();
  }
}
