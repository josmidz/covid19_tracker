import 'package:flutter/material.dart';

class DashLines extends StatelessWidget {
  final double height;
  final Color color;
  DashLines({this.color =  Colors.black,this.height = 1});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context,BoxConstraints constraints){
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth/(2*dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (index) => SizedBox(
            height: dashHeight,
            width: dashWidth,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color
              )
            ),
          )),
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        );
      },
    );
  }
}