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
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  TextEditingController _nouveauCasController = TextEditingController();
  TextEditingController _guerisController = TextEditingController();
  TextEditingController _decesController = TextEditingController();

  var _decesFocusNode = FocusNode();
  var _nouveauCasFocusNode = FocusNode();
  var _guerisFocusNode = FocusNode();

  var _formKey = GlobalKey<FormState>();
  _swapFocus(FocusNode oldnode,BuildContext context,[FocusNode newnode]){
    oldnode.unfocus();
    if(newnode != null){
      FocusScope.of(context).requestFocus(newnode);
      return;
    } else {
      _validateInput(context);
    }
  }

  _validateInput(BuildContext context,){
    var form = _formKey.currentState;
    if(!form.validate()){
      setState(() {});
      return;
    }
    form.save();
    FocusScope.of(context).unfocus();
  }

  BuildContext _ctx;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: [
              SizedBox(height: 15.0,),
              Text(
                "Ajouter ou mettre à jour les informations relatives au COVID-19 pour votre pays",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ctColor2,
                ),
              ),
              SizedBox(height: 25.0,),
              Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: ctColor2
                ),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  controller: _nouveauCasController,
                  focusNode: _nouveauCasFocusNode,
                  onFieldSubmitted: (v)=>
                    _swapFocus(_nouveauCasFocusNode,context,_decesFocusNode),
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9)
                  ],
                  validator: (String value){
                    if(value.isEmpty) return "Veuillez renseigner le nouveau cas";
                    return null;
                  },
                  onChanged:(s){setState(() {
                    
                  });},
                  decoration: InputDecoration(
                    labelText: 'nouveau cas',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    prefixIcon: Icon(Icons.dialpad),
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
              SizedBox(height: 15.0,),
              Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: ctColor2
                ),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  controller: _decesController,
                  focusNode: _decesFocusNode,
                  onFieldSubmitted: (v)=>
                    _swapFocus(_decesFocusNode,context,_guerisFocusNode),
                  onChanged:(s){setState(() {
                    
                  });},
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (String value){
                    if(value.isEmpty) return "Veuillez renseigner le nombre de décès";
                    return null;
                  },
                  decoration: InputDecoration(
                  //  hintText: 'mot de passe',
                    prefixIcon: Icon(Icons.dialpad),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelText:  'nombre de décès',
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
              SizedBox(height: 15.0,),
              Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: ctColor2
                ),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  controller: _guerisController,
                  focusNode: _guerisFocusNode,
                  onFieldSubmitted: (v)=>
                    _swapFocus(_guerisFocusNode,context),
                  onChanged:(s){setState(() {
                    
                  });},
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                  ],
                  validator: (String value){
                    if(value.isEmpty) return "Veuillez renseigner le nombre de guéris";
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.dialpad),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelText:  'nombre de guéris',
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
                            color:  _formKey.currentState == null || _formKey.currentState.validate() != true
                            ? Theme.of(context).disabledColor 
                            :ctColor2
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
                        onPressed: _formKey.currentState == null || _formKey.currentState.validate() != true
                            ? null
                            : (){
                          BusyDialog.showLoadingDialog(context: context,key: _keyloader);
                          Future.delayed(Duration(milliseconds: 400),(){
                            _saveCovidInfo(context:context);
                          });
                        }
                      ),
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  final _keyloader = GlobalKey<State>();
  void _saveCovidInfo({BuildContext context}) async{
    try {
      EndpointDataModel _result = await httpHelper.postUrl(
        header: {
          "appversion":"${userBloc.appVersion}",
          "cache-control":"no-cache"
        },
        link: "$ctMainLink/covid/add",
        body: {
          "nouveaucas":"${_nouveauCasController.text.trim().toLowerCase()}",
          "gueris":"${_guerisController.text.trim()}",
          "deces":"${_decesController.text.trim()}",
          "token":"${userBloc.userBlocDataModel.usertoken}"
        }
      );
      Navigator.of(_keyloader.currentContext,rootNavigator: true).pop();
      if(_result.error != null){
        if(_result.error is SocketException){
          appShowMessageDialog(
            context: context,
            title: "Covid",
            message: "Echec de l'opération, veuillez vérifier votre connexion internet"
          );
        } else {
          appShowMessageDialog(
            context: context,
            title: "Covid",
            message: "Echec de l'opération, veuillez réessayer ultérieurement"
          );
        }
      } else {
        Map<String,dynamic> _response = _result.data;
        if(_response.containsKey('status') && _response['status'] == true){
          _guerisController.clear();
          _decesController.clear();
          _nouveauCasController.clear();
          userBloc.loadUserInfo();
          Scaffold.of(_ctx)
          .showSnackBar(SnackBar(
            content: Text(_response['message'],style: TextStyle(color: ctColor1),),
            backgroundColor: ctColor2,
          ));
        } else if(_response.containsKey('status') && _response['status']== false){
          appShowMessageDialog(
            context: context,
            title: "Covid",
            message:_response['message']??"Echec de l'opération, veuillez réessayer ultérieurement",
          ); 
        } else {
          appShowMessageDialog(
            context: context,
            title: "Covid",
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
}