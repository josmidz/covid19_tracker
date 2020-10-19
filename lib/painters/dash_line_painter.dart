
import 'package:flutter/material.dart';

class DashLinePainter extends CustomPainter {
  final Color mcolor;
  DashLinePainter({this.mcolor});
  @override
  void paint(Canvas canvas, Size size) {
      double _dashWidth = 9,_dashSpace=5,_startX=0;
      final paint = Paint()
        ..color = Colors.grey
        ..strokeWidth = 1;
      while (_startX < size.width) {
        canvas.drawLine(Offset(_startX,0), Offset(_startX+ _dashWidth,0), paint);
        _startX += _dashWidth + _dashSpace;
      }
    }
  
    @override
    bool shouldRepaint(CustomPainter oldDelegate) {
      return false;
  }
  
}

class InputDashLinePainter extends CustomPainter {
  final Color mcolor;
  final double space;
  final double dashwidth;
  final double dashHeight;
  InputDashLinePainter({this.mcolor,this.space = 5.0,this.dashwidth = 9.0,this.dashHeight = 1});
  @override
  void paint(Canvas canvas, Size size) {
      double _startX=0;
      final paint = Paint()
        ..color = mcolor ?? Colors.grey
        ..strokeWidth = dashHeight;
      while (_startX < size.width) {
        canvas.drawLine(Offset(_startX,size.height), Offset(_startX+ dashwidth,size.height), paint);
        _startX += dashwidth + space;
      }
    }
  
    @override
    bool shouldRepaint(CustomPainter oldDelegate) {
      return false;
  }
  
}