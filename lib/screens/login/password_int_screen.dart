import 'package:covid19_tracker/utils/ct_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordInitScreen extends StatefulWidget {
  final VoidCallback voidCallback;
  PasswordInitScreen({this.voidCallback});
  @override
  _PasswordInitScreenState createState() => _PasswordInitScreenState();
}

class _PasswordInitScreenState extends State<PasswordInitScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30,),
          Row(
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  height: 40.0,
                //  width: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
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
                onPressed:widget.voidCallback
              )
            ],
          )
        ],
      ),
    );
  }
}