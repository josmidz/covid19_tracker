
import 'package:covid19_tracker/utils/ct_colors.dart';
import 'package:flutter/material.dart';

class MyCardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
      var paint = Paint()
        ..color = ctColor6.withOpacity(0.2);
      final width = size.width;
      final height = size.height;
      var path = Path();
      path.moveTo(0, height * 0.98);
      path.quadraticBezierTo(width/4, height*0.7, (width/2)+20, height*0.9);
      path.quadraticBezierTo(width-20, height, width, height*0.85);
      // path.lineTo(width, height * 0.7);
      // path.lineTo(0, height);
      path.lineTo(width, height);
      // path.lineTo(width, 0);
      path.lineTo(0, height);
      // path.close();
      canvas.drawPath(path, paint);

      paint = Paint()
        ..color = ctColor2.withOpacity(0.15);
      path = Path();
      path.moveTo(0, height * 0.9);
      path.quadraticBezierTo(width/4, height*0.75, width/2, height*0.9);
      path.quadraticBezierTo(width-(width/4), height, width, height*0.7);
      // path.lineTo(width, height * 0.7);
      // path.lineTo(0, height);
      path.lineTo(width, height);
      // path.lineTo(width, 0);
      path.lineTo(0, height);
      // path.close();
      canvas.drawPath(path, paint);
    }
  
    @override
    bool shouldRepaint(CustomPainter oldDelegate) {
      return true;
  }
  
}