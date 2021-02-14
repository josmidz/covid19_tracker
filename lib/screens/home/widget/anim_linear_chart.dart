import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid19_tracker/blocs/covid/covid_bloc.dart';
import 'package:covid19_tracker/utils/ct_list_colors.dart';
import 'package:flutter/material.dart';

class AnimLinearChart extends StatefulWidget {
  final List<CovidChildInfoDataModel> listStats;
  final loopIndex;
  final selectedIndex;
  AnimLinearChart({this.loopIndex, this.listStats = const[],this.selectedIndex});
  @override
  _AnimLinearChartState createState() => _AnimLinearChartState();
}

class _AnimLinearChartState extends State<AnimLinearChart>
    with TickerProviderStateMixin {
  AnimationController _controller;
  var total  = 0.0;
  var _moyen = 0.0;
  _onAnimating(){
    for (var i = 0; i < widget.listStats.length; i++) {
      total += widget.listStats[i].stats[widget.selectedIndex].value;
    }
    _moyen = (widget.listStats[widget.loopIndex].stats [widget.selectedIndex].value * 1)/total;
    _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 1200));
    _controller.addListener(()=>this.setState(() {}));
    _onAnimating();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10.0,),
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: ctListColors[widget.listStats.indexOf(widget.listStats[widget.loopIndex])],
                      ),
                      SizedBox(width: 5.0,),
                      Text(
                        "${widget.listStats[widget.loopIndex].country.countryname}",
                        style: TextStyle(
                          color: ctListColors[widget.listStats.indexOf(widget.listStats[widget.loopIndex])],
                          // fontSize: 14.0,
                          // fontWeight: FontWeight.w800
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [ 
                Expanded(
                  child: Transform(
                    transform: Matrix4.rotationY(-pi),
                    origin: Offset((0.5 * MediaQuery.of(context).size.width)/3, 0.0),
                    child: LinearProgressIndicator(
                      backgroundColor: ctListColors[widget.loopIndex],
                      value: 1.0 - (_moyen * _controller.value),
                      minHeight: 8.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[300])
                    ),
                  ),
                ),
                SizedBox(width: 8.0,),
                AutoSizeText(
                  "${(_moyen * 100).toStringAsFixed(2)}%",
                  maxLines: 1,
                  style: TextStyle(
                    color: ctListColors[widget.loopIndex]
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}