import 'dart:convert';
import 'dart:io';

import 'package:covid19_tracker/blocs/user/user_bloc.dart';
import 'package:covid19_tracker/datasource/db/user_db_helper.dart';
import 'package:covid19_tracker/datasource/http/http_helper.dart';
import 'package:covid19_tracker/datasource/http/main_link.dart';
import 'package:covid19_tracker/utils/app_show_dialog.dart';
import 'package:covid19_tracker/utils/busy_dialogs.dart';
import 'package:covid19_tracker/utils/ct_colors.dart';
import 'package:covid19_tracker/utils/is_email_phone.dart';
import 'package:covid19_tracker/utils/save_file_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  final Function openRegister;
  final Function onLoginSuccess;
  LoginScreen({this.openRegister,this.onLoginSuccess});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  BuildContext _ctx;
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _usernameFocusNode = FocusNode();
  var _passwordFocusNode = FocusNode();

  _swapFocus(FocusNode oldnode,BuildContext context,[FocusNode newnode]){
    oldnode.unfocus();
    if(newnode != null) {
      FocusScope.of(context).requestFocus(newnode);
    } else {
      _validateInput(context);
    }
  }

  _validateInput(BuildContext context){
    var form = _formKey.currentState;
    if(!form.validate()){
      setState(() {});
      return;
    }
    form.save();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidate: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.0,),
              Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: ctColor2
                ),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: _userNameController,
                  focusNode: _usernameFocusNode,
                  onFieldSubmitted: (v)
                    =>_swapFocus(_usernameFocusNode,context,_passwordFocusNode),
                  decoration: InputDecoration(
                    labelText: 'john@email.com',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    prefixIcon: Icon(LineAwesomeIcons.mail_bulk),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(12, 2, 12, 2),
                    fillColor: Colors.grey[100],
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: ctColor2
                      ),
                    ),
                    enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Colors.grey[400]
                      ),
                    ),
                  ),
                  validator: (String value){
                    if(value.isEmpty) return "Votre adresse email est requise";
                    if(!isEmail(email:value)) return "Le format de votre adresse email n'est pas valide";
                    return null;
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(30)
                  ],
                ),
              ),
              SizedBox(height: 15.0,),
              Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: ctColor2
                ),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  controller: _passwordController,
                  obscureText: true,
                  focusNode: _passwordFocusNode,
                  onFieldSubmitted: (v)
                    =>_swapFocus(_passwordFocusNode,context),
                  validator: (String value){
                    if(value.isEmpty) return "Votre mot de passe est requis";
                    if(value.trim().length < 8) return "Votre mot de passe doit contenir au moins 8 caractères";
                    return null;
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(30)
                  ],
                  decoration: InputDecoration(
                  //  hintText: 'mot de passe',
                    prefixIcon: Icon(LineAwesomeIcons.lock),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelText:  'mot de passe',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(12, 2, 12, 2),
                    fillColor: Colors.grey[100],
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: ctColor2
                      ),
                    ),
                    enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Colors.grey[400]
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 15.0,),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     CupertinoButton(
              //       padding: EdgeInsets.zero,
              //       child: Container(
              //         height: 20.0,
              //       //  width: 200.0,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(15.0),
              //           // color: ctColor12
              //         ),
              //         child: Center(
              //           child: Text(
              //             "Mot de pass oublié ?",
              //             style: TextStyle(
              //               color: ctColor6
              //             ),
              //           ),
              //         ),
              //       ), 
              //       onPressed: (){
              //         widget.openRegister();
              //       }
              //     )
              //   ],
              // ),
              SizedBox(height: 15.0,),
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
                          color:_formKey.currentState == null || _formKey.currentState.validate() != true
                            ? Theme.of(context).disabledColor
                            : ctColor2
                        ),
                        child: Center(
                          child: Text(
                            "Connexion",
                            style: TextStyle(
                              color: ctColor1
                            ),
                          ),
                        ),
                      ), 
                      onPressed:_formKey.currentState == null || _formKey.currentState.validate() != true
                            ?null
                            :(){
                              BusyDialog.showLoadingDialog(context: context,key: _keyLoader);
                              Future.delayed(Duration(milliseconds: 300),(){
                                _login();
                              });
                            }
                    ),
                  )
                ],
              ),
              SizedBox(height: 35.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Vous n'avez pas de compte ? ",
                      style: TextStyle(
                        color: ctColor2
                      ),
                    ),
                  )
                ],
              ),
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
                            "Créer un nouveau compte",
                            style: TextStyle(
                              color: ctColor6
                            ),
                          ),
                        ),
                      ), 
                      onPressed: (){
                        widget.openRegister();
                      }
                    ),
                  )
                ],
              ),
              SizedBox(height: 25.0,),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Checkbox(
              //         value: true, onChanged: (v){},
              //         activeColor: ctColor2,
              //     ),
              //     Flexible(
              //       child: Text(
              //         "En vous connectant à cette application vous acceptez les termes de confidentialités et les conditions d'utilisations",
              //         style: TextStyle(
              //           color: ctColor2
              //         ),
              //       ),
              //     )
              //   ],
              // ),
            ],
        ),
      ),
    );
  }

  final _keyLoader  = GlobalKey<State>();
  void _login() async {
    try {
      EndpointDataModel _result = await httpHelper.postUrl(
        header: {
          "appversion":"${userBloc.appVersion}",
          "cache-control":"no-cache"
        },
        link: "$ctMainLink/experts/login",
        body: {
          "username":"${_userNameController.text.trim().toLowerCase()}",
          "password":"${_passwordController.text.trim()}"
        }
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
          //save user in db
          var _data = _response['data'];
          _saveInfo(_data);
          widget.onLoginSuccess();
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

    } catch(e){
      Scaffold.of(_ctx)
        .showSnackBar(SnackBar(
          content: Text("Echec de l'opération",style: TextStyle(color: ctColor1),),
          backgroundColor: ctColor2,
        ));
    }
  }

  final _dbHelper = UserDbHelper();
  void _saveInfo(Map<String,dynamic> data) async {
     //save user in db
     var _imageName ='empty';
     var _flagName ='empty';
     if(data['photo'] != 'empty'){
       var _photo = base64Decode(data['photo']);
       bool _saved = await saveImageFileLocally(bytes: _photo,filename: "user_profil_pic.png");
       if(_saved) _imageName = "user_profil_pic.png";
     }

     //save flag
     var _flag = base64Decode(data['countryflag']);
      bool _flagsaved = await saveImageFileLocally(bytes: _flag,filename: "country_flag.png");
      if(_flagsaved) _flagName = "country_flag.png";

      UserDataModel _userDatModel = UserDataModel(
        countrycode : data['countrycode'],
        countrynat  : data['countrynat'],
        countryflag : _flagName,
        usertoken: data['token'],
        countryid   : data['countryid'],
        countryname : data['countryname'],
        email       : data['username'],
        nom         : data['nom'],
        prenom      : data['prenom'],
        picture     : _imageName,
      );

      //delete existing user
      List<UserDataModel> _users = await _dbHelper.getUsers();
      for (var item in _users) {
        int _del = await _dbHelper.deleteUser(item.dbid);

      }

      //save in db
      await _dbHelper.insertUser(user:_userDatModel);

      final udb = await _dbHelper.getUserInfo();
      print("user saved $udb");
      LocalFileModel _localFileModel 
        = await loadLocalfiles(flag: udb.countryflag,photo: udb.picture);

      UserDataModel _last 
      = UserDataModel.fromMap(map:{...udb.toMap(),...{countryFlagBytesColumn:_localFileModel.flag,userPhotoBytesColumn:_localFileModel.photo} });

      //ASSIGN TO BLOC
      userBloc.assignUser(udataModel:_last);
      widget.onLoginSuccess();
      Navigator.of(_ctx).pop();
  }

}