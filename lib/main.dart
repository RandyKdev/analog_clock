import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './PaintUI.dart';
import './Hands.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(backgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Clock',
      home: Clock(),
    );
  }
}

class Clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    DateTime time = DateTime.now();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    if ((screenWidth / screenHeight) > (5 / 3)) {
      screenWidth = screenHeight * 5 / 3;
    } else {
      screenHeight = screenWidth * 3 / 5;
    }
//    screenHeight = screenWidth * 3 / 5;
    return Center(
      child: AspectRatio(
        aspectRatio: 5.0 / 3.0,
        child: Container(
          color: Colors.teal[900],
            child: Stack(
          children: <Widget>[
            CustomPaint(
              painter: PaintUI(screenWidth, screenHeight, 'outCircle'),
            ),
            Column(
              children: strokes(screenWidth, screenHeight),
            ),
            Stack(
              children: numbers(screenHeight, screenWidth),
            ),
            Hands(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              type: 'HourHand',
              time: (time.hour * 3600) + (time.minute * 60) + time.second
            ),
            Hands(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              type: 'MinuteHand',
              time: (time.minute * 60) + time.second
            ),
            Hands(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              type: 'SecondHand',
              time: time.second,
            ),
//            HourHand((time.hour * 3600) + (time.minute * 60) + time.second),
//            MinuteHand((time.minute * 60) + time.second),
//            SecondHand(time.second),
            CustomPaint(
              painter: PaintUI(screenWidth, screenHeight, 'circle'),
            ),
          ],
        )),
      ),
    );
  }
}

List numbers(double screenHeight, double screenWidth) {
  List<Widget> nums = [];
  nums.add(Positioned(
    top: (screenHeight / 360) * 37,
    left: screenWidth / 2 - 10,
    child: Text('12', style: TextStyle(decoration: TextDecoration.none, color: Colors.white, fontSize: 18),),
  ),);
  nums.add(Positioned(
    top: screenHeight / 2 - 12,
    left: (screenWidth / 2)  + (screenHeight / 2) - 15 - (screenHeight / 360) * 37,
    child: Text('3', style: TextStyle(decoration: TextDecoration.none, color: Colors.white, fontSize: 18),),
  ),);
  nums.add(Positioned(
    top: (screenHeight) - (screenHeight / 360) * 37 - 22,
    left: (screenWidth / 2) - 5,
    child: Text('6', style: TextStyle(decoration: TextDecoration.none, color: Colors.white, fontSize: 18),),
  ),);
  nums.add(Positioned(
    top: (screenHeight / 2) - 12,
    left: (screenWidth / 2) - ((screenHeight / 2) - 10) + (screenHeight / 360) * 37,
    child: Text('9', style: TextStyle(decoration: TextDecoration.none, color: Colors.white, fontSize: 18),),
  ),);
  return nums;
}
List strokes(double screenWidth, double screenHeight) {
  List<Widget> stroke = [];
  for (int i = 0; i < 60; i++) {
    stroke.add(
      Transform.rotate(
        origin: Offset(screenWidth / 2, screenHeight / 2),
        angle: i * 0.10472,
        child: CustomPaint(
          painter: PaintUI(screenWidth, screenHeight, 'strokes', index: i),
        ),
      ),
    );
  }
  return stroke;
}
