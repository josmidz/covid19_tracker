import 'package:covid19_tracker/utils/ct_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

class SuccessScreen extends StatefulWidget {
  final VoidCallback callbackAction;
  SuccessScreen({this.callbackAction});
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> with TickerProviderStateMixin {
  GifController _controller;

  @override
  void initState() {
    _controller = GifController(vsync: this);
    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        _controller.stop();
      }
     });
    //  _controller.forward();
    _controller.animateTo(35,duration: Duration(milliseconds: 1000));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100, 
            child: GifImage(
              controller: _controller,
              fit: BoxFit.cover,
              image: AssetImage('assets/images/success.gif')
            ),
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Flexible(
                 child: Text(
                  "Félicitation votre compte a été crée avec succè, vous pouvez vous connectez et profiter de toutes les fonctionnalités",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ctColor2
                  ),
              ),
               )
            ],
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  height: 35.0,
                //  width: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: ctColor2
                  ),
                  child: Center(
                    child: Text(
                      "Terminer",
                      style: TextStyle(
                        color: ctColor1
                      ),
                    ),
                  ),
                ), 
                onPressed:widget.callbackAction
              )
            ],
          )
        ],
      ),
    );
  }
}
