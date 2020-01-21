import 'package:flutter/material.dart';
import './PaintUI.dart';

class Hands extends StatefulWidget {
  final int time;
  final String type;
  final double screenWidth, screenHeight, pi;
  Hands(
      {@required this.time,
      @required this.type,
      @required this.screenHeight,
      @required this.screenWidth,
      @required this.pi})
      : assert(type != null),
        assert(time != null),
        assert(screenWidth != null),
        assert(screenHeight != null),
        assert(pi != null);

  @override
  _HandsState createState() => _HandsState();
}

class _HandsState extends State<Hands> with TickerProviderStateMixin {
  double angle;
  Animation<double> animation;
  AnimationController controller;
  @override
  initState() {
    super.initState();
    // Add listeners to this class
    if (widget.type == 'SecondHand') {
      angle = (widget.time + 3) * (widget.pi / 30);
    } else if (widget.type == 'MinuteHand') {
      angle = (widget.time + 3) * (widget.pi / 1800);
    } else if (widget.type == 'HourHand') {
      angle = (widget.time + 3) * (widget.pi / 21600);
    }

    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    Tween _tween = Tween<double>(begin: 0, end: angle);
    animation = _tween.animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0,
          widget.type == 'SecondHand' ? 0.8 : 1,
          curve: widget.type == 'SecondHand' ? Curves.bounceOut : Curves.linear,
        ),
      ),
    )
      ..addListener(() => setState(() => angle = animation.value))
      ..addStatusListener((status) {
        if ((status == AnimationStatus.completed)) {
          _tween.begin = _tween.end;

          if (widget.type == 'SecondHand') {
            _tween.end = _tween.end + (widget.pi / 30);
          } else if (widget.type == 'MinuteHand') {
            _tween.end = _tween.end + (widget.pi * 2);
          } else if (widget.type == 'HourHand') {
            _tween.end = _tween.end + (widget.pi * 2);
          }

          controller.reset();

          if (widget.type == 'SecondHand') {
            controller.duration = Duration(milliseconds: 999);
          } else if (widget.type == 'MinuteHand') {
            controller.duration = Duration(minutes: 60);
          } else if (widget.type == 'HourHand') {
            controller.duration = Duration(hours: 12);
          }

          controller.forward();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      origin: Offset(widget.screenWidth / 2, widget.screenHeight / 2),
      child: CustomPaint(
        painter: PaintUI(
            screenWidth: widget.screenWidth,
            screenHeight: widget.screenHeight,
            type: widget.type),
      ),
    );
  }
}
