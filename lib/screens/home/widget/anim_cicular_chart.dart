import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid19_tracker/utils/ct_list_colors.dart';
import 'package:flutter/material.dart';

class AnimCircularChart extends StatefulWidget {
  final List<dynamic> listStats;
  final index;
  AnimCircularChart({this.listStats = const[],this.index});
  @override
  _AnimCircularChartState createState() => _AnimCircularChartState();
}

class _AnimCircularChartState extends State<AnimCircularChart>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var total  = 0.0;
  var _moyen = 0.0;
  _onAnimating(){
    for (var i = 0; i < widget.listStats.length; i++) {
      total += widget.listStats[i]['valeur'];
    }
    _moyen = (widget.listStats[widget.index]['valeur'] * 1)/total;
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
      child: SizedBox(
        height: 70.0,
        width: 70.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 70.0,
              width: 70.0,
              child: CircularProgressIndicator(
                backgroundColor: ctListColors[widget.index],
                strokeWidth: 5.0,
                value: 1.0 - (_moyen * _controller.value),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[300])
              ),
            ),
            SizedBox(
              height: 50.0,
              width: 50.0,
              child: Center(
                child: AutoSizeText(
                  "${(_moyen * 100).toStringAsFixed(2)}%",
                  maxLines: 1,
                  style: TextStyle(
                    color: ctListColors[widget.index]
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}