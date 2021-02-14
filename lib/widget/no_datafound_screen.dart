import 'package:covid19_tracker/utils/ct_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

class NoDataFoundScreen extends StatefulWidget {
  final title;
  final message;
  final VoidCallback refresh;
  NoDataFoundScreen({this.message,this.title,this.refresh});
  @override
  _NoDataFoundScreenState createState() => _NoDataFoundScreenState();
}

class _NoDataFoundScreenState extends State<NoDataFoundScreen>
    with TickerProviderStateMixin {
  GifController _controller;

  @override
  void initState() {
    _controller = GifController(vsync: this);
    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        _controller.stop();
      }
     });
    //  controller1.forward();
    _controller.animateTo(24,duration: Duration(milliseconds: 1000));
    super.initState();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100, 
                  child: GifImage(
                    controller: _controller,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/bulb.gif')
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    widget.title ?? "Pas d'information",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ctColor2,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    widget.message ?? "Aucune information n'a été trouvée",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            if(widget.refresh != null)
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
                          "Actualiser",
                          style: TextStyle(
                            color: ctColor1
                          ),
                        ),
                      ),
                    ), 
                    onPressed:widget.refresh
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
 