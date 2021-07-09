import 'package:flutter/material.dart';

class BluePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.white;
    canvas.drawPath(mainBackground,paint);
    Path ovalPath = Path();
    // Start paint from 0% height to the left
    ovalPath.moveTo(0, 0);


    // paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(-width*0.5,height*0.4, width*0.5, height*0.4);
    ovalPath.quadraticBezierTo(width*1.5, height*0.4, width*1.5, -height*.4);



    // ovalPath.quadraticBezierTo(
    //     0, height*0.5, width, height);

    // Paint a curve from current position to bottom left of screen at width * 0.1
    // ovalPath.quadraticBezierTo(width * 0.58, height * 0.8, width * 0.1, height);

    // draw remaining line to bottom left side
    //  ovalPath.lineTo(width, height*0.5);

    // Close line to reset it back
    ovalPath.close();

    paint.color = Color(0xFF15317E);;
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != this;
  }

}
