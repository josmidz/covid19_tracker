
import 'package:covid19_tracker/utils/ct_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void appShowMessageDialog({@required BuildContext context,String message,String title}){
  showCupertinoDialog(
    context: context, 
    builder: (BuildContext _) {
      return CupertinoAlertDialog(
        title: Text(
          title??"Message",
          style: TextStyle(
            color: ctColor2
          ),
        ),
        content: Container(
          child: Text(
            message??"Echec de l'opération, veuillez réessayer ultérieurement",
            style: TextStyle(
              color: Colors.grey[800]
            ),
          ),
        ),
        actions: [
          OutlineButton(
            onPressed:()=>Navigator.of(context).pop(),
            child: Text("OK"),
          )
        ],
      );
    }
  );
}