import 'package:flutter/material.dart';
import './PaintUI.dart';


class Hands extends StatefulWidget {
  final int time;
  final String type;
  final double screenWidth, screenHeight;
  Hands({
    @required this.time,
    @required this.type,
    @required this.screenHeight,
    @required this.screenWidth}) :
        assert(type != null),
        assert(time != null),
        assert(screenWidth != null),
        assert(screenHeight != null);
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
      angle = (widget.time + 3) * 0.10472;
    } else if (widget.type == 'MinuteHand') {
      angle = (widget.time + 3) * 6.28319 / 3600;
    } else if (widget.type == 'HourHand') {
      angle = (widget.time + 3) * (6.28319 / 43200);
    }

    controller = AnimationController(
        duration: Duration(seconds: 2),
        vsync: this
    );

    Tween _tween = Tween<double>(begin: 0, end: angle);
    animation = _tween.animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0,
          1,
          curve: widget.type == 'SecondHand' ? Curves.bounceOut : Curves.linear,
        ),
      ),
    )
      ..addListener(() => setState(() => angle = animation.value))
      ..addStatusListener((status) {
        if ((status == AnimationStatus.completed)) {

          _tween.begin = _tween.end;

          if (widget.type == 'SecondHand') {
            _tween.end = _tween.end + 0.10472;
          } else if (widget.type == 'MinuteHand') {
            _tween.end = _tween.end + 6.28319;
          } else if (widget.type == 'HourHand') {
            _tween.end = _tween.end + 6.28319;
          }

          controller.reset();

          if (widget.type == 'SecondHand') {
            controller.duration = Duration(seconds: 1);
          } else if (widget.type == 'MinuteHand') {
            controller.duration = Duration(hours: 1);
          } else if (widget.type == 'HourHand') {
            controller.duration = Duration(hours: 12);
          }

          controller.forward();
        } else if(status == AnimationStatus.dismissed) {
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
        painter: PaintUI(widget.screenWidth, widget.screenHeight, widget.type),
      ),
    );
  }
}