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
    const double pi =
        3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    if ((screenWidth / screenHeight) > (5 / 3)) {
      screenWidth = screenHeight * 5 / 3;
    } else {
      screenHeight = screenWidth * 3 / 5;
    }
    return Center(
      child: AspectRatio(
        aspectRatio: 5.0 / 3.0,
        child: Container(
            color: Colors.teal[900],
            child: Stack(
              children: <Widget>[
                CustomPaint(
                  painter: PaintUI(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      type: 'outCircle'),
                ),
                Column(
                  children: strokes(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      pi: pi),
                ),
                Stack(
                  children: numbers(
                      screenHeight: screenHeight, screenWidth: screenWidth),
                ),
                Hands(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    type: 'HourHand',
                    pi: pi,
                    time:
                        (time.hour * 3600) + (time.minute * 60) + time.second),
                Hands(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    type: 'MinuteHand',
                    pi: pi,
                    time: (time.minute * 60) + time.second),
                Hands(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  type: 'SecondHand',
                  time: time.second,
                  pi: pi,
                ),
                CustomPaint(
                  painter: PaintUI(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      type: 'circle'),
                ),
              ],
            )),
      ),
    );
  }
}

List numbers({@required double screenHeight, @required double screenWidth}) {
  List<Widget> nums = [];
  nums.add(
    Positioned(
      top: (screenHeight / 360) * 37,
      left: (screenWidth / 2) - 10,
      child: Text(
        '12',
        style: TextStyle(
            decoration: TextDecoration.none, color: Colors.white, fontSize: 18),
      ),
    ),
  );
  nums.add(
    Positioned(
      top: (screenHeight / 2) - 12,
      left: (screenWidth / 2) +
          ((screenHeight / 2) - 15) -
          (screenHeight / 360) * 37,
      child: Text(
        '3',
        style: TextStyle(
            decoration: TextDecoration.none, color: Colors.white, fontSize: 18),
      ),
    ),
  );
  nums.add(
    Positioned(
      top: screenHeight - ((screenHeight / 360) * 37) - 22,
      left: (screenWidth / 2) - 5,
      child: Text(
        '6',
        style: TextStyle(
            decoration: TextDecoration.none, color: Colors.white, fontSize: 18),
      ),
    ),
  );
  nums.add(
    Positioned(
      top: (screenHeight / 2) - 12,
      left: (screenWidth / 2) -
          ((screenHeight / 2) - 10) +
          (screenHeight / 360) * 37,
      child: Text(
        '9',
        style: TextStyle(
            decoration: TextDecoration.none, color: Colors.white, fontSize: 18),
      ),
    ),
  );
  return nums;
}

List strokes(
    {@required double screenWidth,
    @required double screenHeight,
    @required double pi}) {
  List<Widget> stroke = [];
  for (int i = 0; i < 60; i++) {
    stroke.add(
      Transform.rotate(
        origin: Offset(screenWidth / 2, screenHeight / 2),
        angle: i * (pi / 30),
        child: CustomPaint(
          painter: PaintUI(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              type: 'strokes',
              index: i),
        ),
      ),
    );
  }
  return stroke;
}
