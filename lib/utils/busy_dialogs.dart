
import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid19_tracker/utils/ct_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BusyDialog {
  static Future<void> showLoadingDialog(
      {BuildContext context, GlobalKey key,dynamic bgcolor,dynamic ttlecolor,dynamic title,Widget child}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
                key: key,
                backgroundColor: Colors.transparent,//Colors.black54
                children: <Widget>[
                  Center(
                    child: Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      color: bgcolor?? ctColor12,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 5.0,),
                        child??CircularProgressIndicator(
                          backgroundColor: ctColor2,
                        ),
                        SizedBox(height: 1.0,),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: AutoSizeText(
                            title??"patientez...",
                            maxLines: 1,
                            style: TextStyle(
                                color: ctColor2 ?? ttlecolor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  )
                ]));
      });
  }
}