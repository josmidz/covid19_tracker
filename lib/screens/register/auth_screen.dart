import 'dart:io';

import 'package:covid19_tracker/blocs/user/user_bloc.dart';
import 'package:covid19_tracker/datasource/http/http_helper.dart';
import 'package:covid19_tracker/datasource/http/main_link.dart';
import 'package:covid19_tracker/utils/app_show_dialog.dart';
import 'package:covid19_tracker/utils/busy_dialogs.dart';
import 'package:covid19_tracker/utils/ct_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

class AuthScreen extends StatefulWidget {
  final VoidCallback openLogin;
  final Function(int page) toggleNext;
  AuthScreen({this.openLogin,this.toggleNext});
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  GifController controller1;
  var _formKey = GlobalKey<FormState>();
  TextEditingController _codeEditingController = TextEditingController();

  @override
  void initState() {
    controller1 = GifController(vsync: this);
    controller1.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        // controller1.stop();
      }
     });
    //  controller1.forward();
    controller1.repeat(min:0,max:29,period:Duration(seconds:2));
    super.initState();
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100, 
            child: GifImage(
              controller: controller1,
              fit: BoxFit.cover,
              image: AssetImage('assets/images/exclamation.gif')
            ),
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Flexible(
                 child: Text(
                  "Veuillez saisir le code d'authentification qui vous a été envoyé",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ctColor2
                  ),
              ),
               )
            ],
          ),
          SizedBox(height: 30,),
          Form(
            key: _formKey,
            autovalidate: true,
            child: Column(
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150.0,
                      // height: 40.0,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _codeEditingController,
                        textInputAction: TextInputAction.send,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                              color: ctColor2,
                              width: 0.5,
                              style: BorderStyle.solid),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 8.0),
                          filled: true,
                          hintText: "code",
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                              color: ctColor2,
                              width: 0.5,
                              style: BorderStyle.solid),
                          )
                        ),
                        validator: (String v){
                          if(v.isEmpty) return "Veuillez saisir le code de confirmation";
                          return null;
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(8)
                        ],
                      ),
                    ), 
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10,),
                    Expanded(
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 25.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: ctColor8
                          ),
                          child: Center(
                            child: Text(
                              "Renvoyer le code",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ctColor1
                              ),
                            ),
                          ),
                        ), 
                        onPressed: (){
                          BusyDialog.showLoadingDialog(context: context,key: _keyLoader,);
                          Future.delayed(Duration(milliseconds: 800),(){
                            _reSendAuthCode(context: context);
                          });
                        }
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 25.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: ctColor2
                          ),
                          child: Center(
                            child: Text(
                              "Valider",
                              style: TextStyle(
                                color: ctColor1
                              ),
                            ),
                          ),
                        ), 
                        onPressed: (){
                          if(_codeEditingController.text.trim().length <=1) return;
                          BusyDialog.showLoadingDialog(context: context,key: _keyLoader,);
                          Future.delayed(Duration(milliseconds: 800),(){
                            _sendAuthCode(context: context,code: _codeEditingController.text.trim());
                          });
                        }
                      ),
                    ),
                    SizedBox(width: 10,),
                  ],
                ),
                SizedBox(height: 15,),
              ],
            ),
          ),
          SizedBox(height: 25.0,),
          Row(
            children: [
              Expanded(
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Container(
                    height: 40.0,
                  //  width: 200.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      // color: ctColor12
                    ),
                    child: Center(
                      child: Text(
                        "Terminer",
                        style: TextStyle(
                          color: ctColor6
                        ),
                      ),
                    ),
                  ), 
                  onPressed: (){
                    widget.openLogin();
                  }
            ),
              )
            ],
          ),
          SizedBox(height: 25.0,),
        ],
      ),
    );
  }

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  void _sendAuthCode({dynamic code,BuildContext context}) async{
    try {
      EndpointDataModel _result = await httpHelper.getUrl(
        header: {
          "cache-control":'no-cache',
          "Content-Type"  : "application/json",
          "appversion"    : "${userBloc.appVersion}"
        },
        link: "$ctMainLink/experts/validation/${userBloc.registerToken}/code/$code"
      );
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
      if(_result.error != null){
        if(_result.error is SocketException){
          showCupertinoDialog(
            context: context, 
            builder: (BuildContext _) {
              return CupertinoAlertDialog(
                title: Text(
                  "Authentification",
                  style: TextStyle(
                    color: ctColor2
                  ),
                ),
                content: Container(
                  child: Text(
                    "Echec de l'opération, veuillez vérifier votre connexion internet",
                    style: TextStyle(
                      color: ctColor2
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
        } else {
          showCupertinoDialog(
            context: context, 
            builder: (BuildContext _) {
              return CupertinoAlertDialog(
                title: Text(
                  "Authentification",
                  style: TextStyle(
                    color: ctColor2
                  ),
                ),
                content: Container(
                  child: Text(
                    "Echec de l'opération, veuillez réessayer ultérieurement",
                    style: TextStyle(
                      color: ctColor2
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
      } else {
        Map<String,dynamic> _response = _result.data;
        if(_response.containsKey('status') && _response['status'] == true){
          userBloc.registerToken = null;
          widget.toggleNext(2);
        } else if(_response.containsKey('status') && _response['status']== false){
          showCupertinoDialog(
            context: context, 
            builder: (BuildContext _) {
              return CupertinoAlertDialog(
                title: Text(
                  "Authentification",
                  style: TextStyle(
                    color: ctColor2
                  ),
                ),
                content: Container(
                  child: Text(
                    _response['message']??"Echec de l'opération, veuillez réessayer ultérieurement",
                    style: TextStyle(
                      color: ctColor2
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
        } else {
          showCupertinoDialog(
            context: context, 
            builder: (BuildContext _) {
              return CupertinoAlertDialog(
                title: Text(
                  "Authentification",
                  style: TextStyle(
                    color: ctColor2
                  ),
                ),
                content: Container(
                  child: Text(
                    "Echec de l'opération, veuillez réessayer ultérieurement",
                    style: TextStyle(
                      color: ctColor2
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
      }
    } catch (e) {
      showCupertinoDialog(
        context: context, 
        builder: (BuildContext _) {
          return CupertinoAlertDialog(
            title: Text(
              "Authentification",
              style: TextStyle(
                color: ctColor2
              ),
            ),
            content: Container(
              child: Text(
                "Echec de l'opération, veuillez réessayer ultérieurement",
                style: TextStyle(
                  color: ctColor2
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
  }

  void _reSendAuthCode({BuildContext context}) async{
    try {
      EndpointDataModel _result = await httpHelper.getUrl(
        header: {
          "cache-control":'no-cache',
          // "Content-Type"  : "application/json",
          "appversion"    : "${userBloc.appVersion}"
        },
        link: "$ctMainLink/experts/resend-code/${userBloc.registerToken}"
      );
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
      if(_result.error != null){
        if(_result.error is SocketException){
          appShowMessageDialog(
            context: context,
            title: "Authentification",
            message: "Echec de l'opération, veuillez vérifier votre connexion internet"
          );
        } else {
          appShowMessageDialog(
            context: context,
            title: "Authentification",
            message: "Echec de l'opération, veuillez réessayer ultérieurement"
          );
        }
      } else {
        Map<String,dynamic> _response = _result.data;
        if(_response.containsKey('status') && _response['status'] == true){
          userBloc.registerToken = null;
          widget.toggleNext(2);
        } else if(_response.containsKey('status') && _response['status']== false){
          appShowMessageDialog(
            context: context,
            title: "Authentification",
            message:_response['message']??"Echec de l'opération, veuillez réessayer ultérieurement",
          ); 
        } else {
          appShowMessageDialog(
            context: context,
            title: "Authentification",
            message: "Echec de l'opération, veuillez réessayer ultérieurement"
          );
        }
      }
    } catch (e) {
      appShowMessageDialog(
        context: context,
        title: "Authentification",
        message: "Echec de l'opération, veuillez réessayer ultérieurement"
      );
    }
  }
  
}