import 'package:flutter/material.dart';

class PaintUI extends CustomPainter {
  Paint _paint;
  Paint _paint1;
  String type, subType;
  double screenWidth, screenHeight;
  int index;
  PaintUI(double screenWidth, double screenHeight, String type,
      {int index, String subType}) {
    this.screenHeight = screenHeight;
    this.screenWidth = screenWidth;
    this.index = index;
    this.type = type;
    this.subType = subType;
    _paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.square
      ..strokeWidth =
          (type == 'outCircle') || ((type == 'strokes') && ((index % 5) == 0))
              ? 1.5
              : 0.5;
    _paint1 = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.2;
  }

  @override
  void paint(Canvas canvas, Size size) {
    switch (type) {
      case 'outCircle':
        _paint.style = PaintingStyle.stroke;
        canvas.drawCircle(Offset(screenWidth / 2, screenHeight / 2),
            (screenHeight / 2) - 15, _paint);
        break;
      case 'strokes':
        if ((index % 5) == 0) {
          _paint.color = Colors.blue;
          canvas
            ..drawLine(
              Offset(screenWidth / 2, (screenHeight / 360) * 37),
              Offset(screenWidth / 2, 27),
              _paint,
            );
        } else {
          canvas
            ..drawLine(
              Offset(screenWidth / 2, (screenHeight / 360) * 29),
              Offset(screenWidth / 2, 27),
              _paint,
            );
        }
        break;
      case 'SecondHand':
        Path _path = Path();
        _path.moveTo((screenWidth - 1) / 2, screenHeight / 9);
        _path.lineTo((screenWidth + 1) / 2, screenHeight / 9);
        _path.lineTo((screenWidth + 1) / 2, (screenHeight * 13) / 24);
        _path.lineTo((screenWidth + 4) / 2, ((screenHeight * 13) / 24) + 4);
        _path.lineTo((screenWidth + 4) / 2, (screenHeight * 5) / 8);
        _path.lineTo((screenWidth - 4) / 2, (screenHeight * 5) / 8);
        _path.lineTo((screenWidth - 4) / 2, ((screenHeight * 13) / 24) + 4);
        _path.lineTo((screenWidth - 1) / 2, (screenHeight * 13) / 24);
        _path.lineTo((screenWidth - 1) / 2, screenHeight / 9);
        canvas.drawPath(_path, _paint);

        Path _path1 = Path();
        _path1.moveTo((screenWidth - 1) / 2, screenHeight / 9);
        _path1.lineTo((screenWidth + 1) / 2, screenHeight / 9);
        _path1.lineTo((screenWidth + 1) / 2, (screenHeight * 13) / 24);
        _path1.lineTo((screenWidth + 4) / 2, ((screenHeight * 13) / 24) + 4);
        _path1.lineTo((screenWidth + 4) / 2, (screenHeight * 5) / 8);
        _path1.lineTo((screenWidth - 4) / 2, (screenHeight * 5) / 8);
        _path1.lineTo((screenWidth - 4) / 2, ((screenHeight * 13) / 24) + 4);
        _path1.lineTo((screenWidth - 1) / 2, (screenHeight * 13) / 24);
        _path1.lineTo((screenWidth - 1) / 2, screenHeight / 9);
        canvas.drawPath(_path1, _paint1);
        break;
      case 'MinuteHand':
      // print(screenWidth);
        Path _path = Path();
        _path.moveTo(screenWidth / 2, screenHeight / 6);
        _path.lineTo((screenWidth * 309 / 600), (screenHeight / 2));
        _path.lineTo((screenWidth / 2), (screenHeight * 17 / 30));
        _path.lineTo((screenWidth * 59 / 120 ) - 4, (screenHeight / 2));
        _path.lineTo(screenWidth / 2, screenHeight / 6);
        canvas.drawPath(_path, _paint);

        Path _path1 = Path();
        _path1.moveTo(screenWidth / 2, screenHeight / 6);
        _path1.lineTo((screenWidth * 309 / 600), (screenHeight / 2));
        _path1.lineTo((screenWidth / 2), (screenHeight * 17 / 30));
        _path1.lineTo((screenWidth * 59 / 120 ) - 4, (screenHeight / 2));
        _path1.lineTo(screenWidth / 2, screenHeight / 6);
        canvas.drawPath(_path1, _paint1);
        break;
      case 'HourHand':
        Path _path = Path();
        _path.moveTo((screenWidth / 2), (screenHeight / 4));
        _path.lineTo(
            (screenWidth * 309 / 600), (screenHeight / 2));
        _path.lineTo((screenWidth / 2), (screenHeight * 17 / 30));
        _path.lineTo(
            (screenWidth * 59 / 120 ) - 4, (screenHeight / 2));
        _path.lineTo(screenWidth / 2, screenHeight / 4);
        canvas.drawPath(_path, _paint);

        Path _path1 = Path();
        _path1.moveTo((screenWidth / 2), (screenHeight / 4));
        _path1.lineTo(
            (screenWidth * 309 / 600), (screenHeight / 2));
        _path1.lineTo((screenWidth / 2), (screenHeight * 17 / 30));
        _path1.lineTo(
            (screenWidth * 59 / 120 ) - 4, (screenHeight / 2));
        _path1.lineTo(screenWidth / 2, screenHeight / 4);
        canvas.drawPath(_path1, _paint1);
        break;
      case 'circle':
        _paint1.style = PaintingStyle.fill;
        canvas.drawCircle(Offset(screenWidth / 2, screenHeight / 2),
            screenHeight / 72, _paint1);

        canvas.drawCircle(Offset(screenWidth / 2, screenHeight / 2),
            screenHeight / 80, _paint);
        break;
      default:
        return null;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
