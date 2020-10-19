import 'package:flutter/material.dart';

class SlipupAnimation extends StatefulWidget {
  final Widget child;
  SlipupAnimation({this.child});
  @override
  _SlipupAnimationState createState() => _SlipupAnimationState();
}

class _SlipupAnimationState extends State<SlipupAnimation>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  var _slideUpTween = Tween<Offset>(begin: Offset(0, 0.4), end: Offset.zero);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 600));
    _animation = CurvedAnimation(
        parent: Tween<double>(begin: 0, end: 1).animate(_controller),
        curve: Curves.fastOutSlowIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position:_slideUpTween.animate(_animation),
        child: widget.child,
      ),
    );
  }
}