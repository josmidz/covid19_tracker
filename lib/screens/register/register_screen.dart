import 'dart:io';

import 'package:covid19_tracker/blocs/country/country_bloc.dart';
import 'package:covid19_tracker/blocs/user/user_bloc.dart';
import 'package:covid19_tracker/datasource/http/http_helper.dart';
import 'package:covid19_tracker/datasource/http/main_link.dart';
import 'package:covid19_tracker/screens/country/country_screen.dart';
import 'package:covid19_tracker/utils/app_show_dialog.dart';
import 'package:covid19_tracker/utils/busy_dialogs.dart';
import 'package:covid19_tracker/utils/ct_colors.dart';
import 'package:covid19_tracker/utils/is_email_phone.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class RegisterScreen extends StatefulWidget {
  final Function openLogin;
  Function(int page) toggleNext;
  RegisterScreen({this.openLogin,this.toggleNext});
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _prenomController = TextEditingController();
  TextEditingController _nomController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();

  var _prenomFocusNode = FocusNode();
  var _nomFocusNode = FocusNode();
  var _emailFocusNode = FocusNode();
  var _passwordFocusNode = FocusNode();
  var _password2FocusNode = FocusNode();

  bool _useCondition = false;

  _swapFocus(FocusNode oldFocus, [FocusNode newFocus]) {
    oldFocus.unfocus();
    if (newFocus != null) {
      FocusScope.of(context).requestFocus(newFocus);
    } else {
      // L'utilisateur a atteint la fin du formulaire
      _validateInputs();
    }
  }

  bool _autoValidate = false;
  _validateInputs() {
    var formState = _formKey.currentState;
    if (!formState.validate()) {
      setState(() => _autoValidate = true);
      return;
    }

    formState.save();
    FocusScope.of(context).unfocus();
    // onFormValidated();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15.0,),
              Row(
                children: [
                  Expanded(
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        _openCountryScrren(context: context);
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.grey[100],
                          border: Border.all(
                            width: 0.5,
                            color: ctColor2
                          )
                        ),
                        child:Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if(_countryDataModel.countryid != null)
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(_countryDataModel.countryflag),
                                      backgroundColor: Colors.grey[300],
                                      radius: 10.0,
                                      onBackgroundImageError: (_,stacktrace){
                                        return Container(
                                          child: Icon(
                                            Icons.error_outline,
                                            color: Colors.red,
                                            size: 22.0,
                                          ),
                                        );
                                      },
                                    )
                                  else
                                    Icon(Icons.outlined_flag,color: Colors.grey[700],),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if(_countryDataModel.countryid != null)
                                    Flexible(
                                      child: Text(
                                        "${_countryDataModel.countryname}",
                                        style: TextStyle(
                                          color: ctColor2,
                                        ),
                                      ),
                                    )
                                  else
                                    Text(
                                      "Sélectionnez votre pays",
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(LineAwesomeIcons.arrow_right,color: Colors.grey[700],),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0,),
              Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: ctColor2
                ),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  controller  : _prenomController,
                  textInputAction: TextInputAction.next,
                  focusNode: _prenomFocusNode,
                  onFieldSubmitted: (v)=>_swapFocus(_prenomFocusNode,_nomFocusNode),
                  decoration: InputDecoration(
                    labelText: 'prénom',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    prefixIcon: Icon(LineAwesomeIcons.user),
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                    LengthLimitingTextInputFormatter(10)
                  ],
                  validator: (String value){
                      if(value.isEmpty) return "Veuillez spécifier votre prénom";
                      value = value.trim();
                      if(value.length < 3) return "Le prénom doit contenir au moins 3 caractères";
                      if(value.length > 10) return "Le prénom ne doit pas avoir plus de 10 caractères";
                      return null;
                  },
                ),
              ),
              SizedBox(height: 15.0,),
              Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: ctColor2
                ),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  controller: _nomController,
                  textInputAction: TextInputAction.next,
                  focusNode: _nomFocusNode,
                  onFieldSubmitted: (v)=>_swapFocus(_nomFocusNode,_emailFocusNode),
                  decoration: InputDecoration(
                    labelText: 'nom',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    prefixIcon: Icon(LineAwesomeIcons.user),
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                    LengthLimitingTextInputFormatter(10)
                  ],
                  validator: (String value){
                      if(value.isEmpty) return "Veuillez spécifier votre nom";
                      value = value.trim();
                      if(value.length < 3) return "Le nom doit contenir au moins 3 caractères";
                      if(value.length > 10) return "Le nom ne doit pas avoir plus de 10 caractères";
                      return null;
                  },
                ),
              ),
              SizedBox(height: 15.0,),
              Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: ctColor2
                ),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  onFieldSubmitted: (v)=>_swapFocus(_emailFocusNode,_passwordFocusNode),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'john@email.com',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    prefixIcon: Icon(Icons.email),
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
                  inputFormatters: [
                    // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                    LengthLimitingTextInputFormatter(30)
                  ],
                  validator: (String value){
                      if(value.isEmpty) return "Veuillez fournir votre adresse email";
                      value = value.trim();
                      if(isEmail(email:value) == false) return "Le format de l'adresse email incorrect";
                      return null;
                  },
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
                  controller: _passwordController,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  focusNode: _passwordFocusNode,
                  onFieldSubmitted: (v)=>_swapFocus(_passwordFocusNode,_password2FocusNode),
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
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(40)
                  ],
                  validator: (String value){
                      if(value.isEmpty) return "Veuillez spécifier votre mot de passe";
                      value = value.trim();
                      if(value.length < 8) return "Le mot de passe ne doit pas être inférieur à 8 caractères";
                      return null;
                  },
                ),
              ),
              SizedBox(height: 15.0,),
              Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: ctColor2
                ),
                child: TextFormField(
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: _password2Controller,
                  focusNode: _password2FocusNode,
                  onFieldSubmitted: (v)=>_swapFocus(_password2FocusNode),
                  decoration: InputDecoration(
                  //  hintText: 'mot de passe',
                    prefixIcon: Icon(LineAwesomeIcons.lock),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelText:  'répéter le mot de passe',
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
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(40)
                  ],
                  validator: (String value){
                      if(value.isEmpty) return "Veuillez répéter votre mot de passe";
                      value = value.trim();
                      if(value.length < 8) return "Le mot de passe ne doit pas être inférieur à 8 caractères";
                      if(value != _passwordController.text.trim()) return "Les deux mot de passe ne correpondent pas";
                      return null;
                  },
                ),
              ),
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
                          color: _formKey.currentState == null || _formKey.currentState.validate() != true
                            ? Theme.of(context).disabledColor 
                            : ctColor2
                        ),
                        child: Center(
                          child: Text(
                            "Créer",
                            style: TextStyle(
                              color: ctColor1
                            ),
                          ),
                        ),
                      ), 
                      onPressed: _formKey.currentState == null || _formKey.currentState.validate() != true
                            ?null
                            : (){
                              if(!_useCondition) {
                               appShowMessageDialog(context: context,title: "Création de compte",message: "Veuillez accépter la condition d'utilisation avant de continuer");
                              } else {
                                BusyDialog.showLoadingDialog(context: context,key: _keyLoader,);
                                Future.delayed(Duration(milliseconds: 800),(){
                                  _createAccount(context: context);
                                });
                              }
                            }
                ),
                  )
                ],
              ),
              SizedBox(height: 15.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _useCondition, 
                    activeColor: ctColor2,
                    onChanged: (v){
                      setState(() {_useCondition =v;});
                    },
                  ),
                  Flexible(
                    child: Text(
                      "En créant un nouveau compte ici, vous acceptez les termes de confidentialités et les conditions d'utilisations",
                      style: TextStyle(
                        color: Colors.grey[600]
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 35.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Avez-vous déjà un compte ? ",
                    style: TextStyle(
                      color: ctColor2
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
                            "Se Connecter",
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
      ),
    );
  }

  CountryDataModel _countryDataModel = CountryDataModel();
  void _openCountryScrren({BuildContext context}) async {
    dynamic _result = await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (__,anim,anim2)=> CountryScreen(),
        transitionDuration: Duration(milliseconds: 400),
        transitionsBuilder: (context,anim,anim2,child) {
          return  FadeTransition(opacity: anim,child: child,);
        }
      )
    );

    if(_result is CountryDataModel) {
      setState(() {
        _countryDataModel = _result;
      });
    }
  }

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  void _createAccount({BuildContext context}) async {
    try {
      EndpointDataModel result = await httpHelper.postUrl(
        header: {
          "Cache-Control" : "no-cache",
          // "Content-Type"  : "application/json",
          "appversion"    : "${userBloc.appVersion}"
        },
        link: "$ctMainLink/experts/register",
        body: {
          "prenom"    : "${_prenomController.text.trim()}",
          "nom"       : "${_prenomController.text.trim()}",
          "username"  : "${_emailController.text.trim()}",
          "password"  : "${_passwordController.text.trim()}",
          "countryid" : "${_countryDataModel.countryid}"
        }
      );
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
      if(result.error != null){
        if(result.error is SocketException){
          appShowMessageDialog(
            context: context,
            title: "Création de compte",
            message: "Echec de l'opération, veuillez vérifier votre connexion internet"
          );
        } else {
          appShowMessageDialog(
            context: context,
            title: "Création de compte",
            message: "Echec de l'opération, veuillez réessayer ultérieurement"
          );
          
        }
      } else {
        Map<String,dynamic> _response = result.data;
        if(_response.containsKey('status') && _response['status'] == true){
          _prenomController.clear();
          _nomController.clear();
          _emailController.clear();
          _passwordController.clear();
          _password2Controller.clear();
          userBloc.registerToken = _response['data'];
          widget.toggleNext(1);
        } else if(_response.containsKey('status') && _response['status']== false){
          appShowMessageDialog(
            context: context,
            title: "Création de compte",
            message: _response['message']??"Echec de l'opération, veuillez réessayer ultérieurement",
          );
          
        } else {
          appShowMessageDialog(
            context: context,
            title: "Création de compte",
            message:"Echec de l'opération, veuillez réessayer ultérieurement",
          ); 
        }
      }
    } catch (e) {
      appShowMessageDialog(
        context: context,
        title: "Création de compte",
        message:"Echec de l'opération, veuillez réessayer ultérieurement",
      ); 
    }
  }

}