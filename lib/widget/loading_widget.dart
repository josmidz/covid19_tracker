
import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 1500));
    _animation = Tween<double>(begin:-3,end:10).animate( CurvedAnimation(
      curve: Curves.linear,
      parent: _controller
    ));
    _controller.addListener(()=>this.setState(() {}));
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0, _animation.value),
            end: Alignment(0, -1),
            colors: [
              Colors.white,
              Colors.grey[400],
              Colors.white,
            ],
            tileMode: TileMode.clamp
          )
        ),
      ),
    );
  }
}