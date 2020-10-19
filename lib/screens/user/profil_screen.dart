import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:covid19_tracker/datasource/db/user_db_helper.dart';
import 'package:covid19_tracker/datasource/http/http_helper.dart';
import 'package:covid19_tracker/datasource/http/main_link.dart';
import 'package:covid19_tracker/utils/app_show_dialog.dart';
import 'package:covid19_tracker/utils/busy_dialogs.dart';
import 'package:covid19_tracker/utils/ct_colors.dart';
import 'package:covid19_tracker/utils/dash_line.dart';
import 'package:covid19_tracker/utils/save_file_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:covid19_tracker/blocs/user/user_bloc.dart';
class ProfilScreen extends StatefulWidget {
  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {

  // final _oldPassword = TextEditingController();
  // final _newPassword = TextEditingController();
  // final _repeatPassword = TextEditingController();
  // final _formKey = GlobalKey<FormState>();
  // var _oldPasswordFocusNode = FocusNode();
  // var _newPasswordFocusNode = FocusNode();
  // var _repeatPasswordFocusNode = FocusNode();
  // bool _autoValidate = false;
  // _validateInputs() {
  //   var formState = _formKey.currentState;
  //   if (!formState.validate()) {
  //     setState(() => _autoValidate = true);
  //     return;
  //   }

  //   formState.save();
  //   FocusScope.of(context).unfocus();
  // }

  // _swapFocus(FocusNode oldFocus, [FocusNode newFocus]) {
  //   oldFocus.unfocus();
  //   if (newFocus != null) {
  //     FocusScope.of(context).requestFocus(newFocus);
  //   } else {
  //     // The user has reached the end of the form
  //     _validateInputs();
  //   }
  // }
  BuildContext _ctx;

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100.0,
          width: 100.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image:userBloc.userBlocDataModel.userPicBytes == null
              ? AssetImage("assets/images/user_pic.png")
              : MemoryImage(userBloc.userBlocDataModel.userPicBytes),
              fit: BoxFit.cover
            )
          ),
          child: Stack(
            children: [
              Positioned(
                right: -2,
                bottom: -3,
                child: FloatingActionButton(
                  onPressed: (){
                    _showBottomSheet(context: context);
                  },
                  mini: true,
                  backgroundColor: ctColor2,
                  child: Icon(Icons.camera),
                ),
                // child: IconButton(
                //   icon: Icon(
                //   Icons.camera), onPressed: (){},
                // ),
              )
            ],
          ),
        ),
        SizedBox(height: 15.0,),
        RichText(
          text: TextSpan(
            text:userBloc.userBlocDataModel.prenom == null
            ?"---"
            :"${userBloc.userBlocDataModel.prenom} ",
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 17.0
            ),
            children: [
              TextSpan(
                text:userBloc.userBlocDataModel.nom == null
                ?"---"
                : "${userBloc.userBlocDataModel.nom}".toUpperCase(),
                style: TextStyle(
                  color: ctColor2,
                  fontSize: 19.0
                ), 
              )
            ]
          )
        ),
        Text(
          userBloc.userBlocDataModel.email == null
          ?"---"
          :"${userBloc.userBlocDataModel.email}",
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 15.0
          ),
        ),
        SizedBox(height: 25.0,),
        // DashLines(color: ctColor2,),
        // SizedBox(height: 15.0,),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Text(
        //       "Changer le mot de passe",
        //       style: TextStyle(
        //         color: ctColor2,
        //         fontSize: 15.0
        //       ),
        //     ),
        //   ],
        // ),
        // SizedBox(height: 15.0,),
        // Form(
        //   key: _formKey,
        //   autovalidate: _autoValidate,
        //   child: Column(
        //     children: [
        //       Theme(
        //         data: Theme.of(context).copyWith(
        //           primaryColor: ctColor2
        //         ),
        //         child: TextFormField(
        //           autofocus: false,
        //           controller: _oldPassword,
        //           keyboardType: TextInputType.visiblePassword,
        //           obscureText: true,
        //           focusNode: _oldPasswordFocusNode,
        //           textInputAction: TextInputAction.next,
        //           onFieldSubmitted: (value) =>
        //               _swapFocus(_oldPasswordFocusNode,_newPasswordFocusNode),
        //           // onSaved: (value) => payload.placeholderName = value,
        //           validator: (String value){
        //             if(value.isEmpty) return "Veuillez spécifier l'ancien mot de passe";
        //             value = value.trim();
        //             if(value.length < 8) return "Le mot de passe doit contenir au moins 8 caractères";
        //             return null;
        //           },
        //           inputFormatters: [
        //             // WhitelistingTextInputFormatter.digitsOnly,
        //             // new LengthLimitingTextInputFormatter(19),
        //             // new CardNumberInputFormatter()
        //             // FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),

        //           ],
        //           decoration: InputDecoration(
        //             prefixIcon: Icon(LineAwesomeIcons.lock_open),
        //             floatingLabelBehavior: FloatingLabelBehavior.auto,
        //             labelText:  'ancien mot de passe',
        //             border: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(15.0)
        //             ),
        //             filled: true,
        //             contentPadding: EdgeInsets.fromLTRB(12, 2, 12, 2),
        //             fillColor: Colors.grey[100],
        //             focusedBorder: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(15.0),
        //               borderSide: BorderSide(
        //                 width: 1.0,
        //                 color: ctColor2
        //               ),
        //             ),
        //             enabledBorder:  OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(15.0),
        //               borderSide: BorderSide(
        //                 width: 1.0,
        //                 color: Colors.grey[400]
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //       SizedBox(height: 10.0,),
        //       Theme(
        //         data: Theme.of(context).copyWith(
        //           primaryColor: ctColor2
        //         ),
        //         child: TextFormField(
        //           autofocus: false,
        //           controller: _newPassword,
        //           keyboardType: TextInputType.visiblePassword,
        //           obscureText: true,
        //           focusNode: _newPasswordFocusNode,
        //           textInputAction: TextInputAction.next,
        //           onFieldSubmitted: (value) =>
        //               _swapFocus(_newPasswordFocusNode,_repeatPasswordFocusNode),
        //           // onSaved: (value) => payload.placeholderName = value,
        //           validator: (String value){
        //             if(value.isEmpty) return "Veuillez spécifier l'ancien mot de passe";
        //             value = value.trim();
        //             if(value.length < 8) return "Le mot de passe doit contenir au moins 8 caractères";
        //             return null;
        //           },
        //           inputFormatters: [
        //             // WhitelistingTextInputFormatter.digitsOnly,
        //             // new LengthLimitingTextInputFormatter(19),
        //             // new CardNumberInputFormatter()
        //             // FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),

        //           ],
        //           decoration: InputDecoration(
        //           //  hintText: 'mot de passe',
        //             prefixIcon: Icon(LineAwesomeIcons.lock),
        //             floatingLabelBehavior: FloatingLabelBehavior.auto,
        //             labelText:  'nouveau mot de passe',
        //             border: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(15.0)
        //             ),
        //             filled: true,
        //             contentPadding: EdgeInsets.fromLTRB(12, 2, 12, 2),
        //             fillColor: Colors.grey[100],
        //             focusedBorder: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(15.0),
        //               borderSide: BorderSide(
        //                 width: 1.0,
        //                 color: ctColor2
        //               ),
        //             ),
        //             enabledBorder:  OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(15.0),
        //               borderSide: BorderSide(
        //                 width: 1.0,
        //                 color: Colors.grey[400]
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //       SizedBox(height: 10.0,),
        //       Theme(
        //         data: Theme.of(context).copyWith(
        //           primaryColor: ctColor2
        //         ),
        //         child: TextFormField(
        //           autofocus: false,
        //           controller: _repeatPassword,
        //           keyboardType: TextInputType.visiblePassword,
        //           obscureText: true,
        //           focusNode: _repeatPasswordFocusNode,
        //           textInputAction: TextInputAction.done,
        //           onFieldSubmitted: (value) =>
        //               _swapFocus(_repeatPasswordFocusNode),
        //           // onSaved: (value) => payload.placeholderName = value,
        //           validator: (String value){
        //             if(value.isEmpty) return "Veuillez spécifier l'ancien mot de passe";
        //             value = value.trim();
        //             if(value.length < 8) return "Le mot de passe doit contenir au moins 8 caractères";
        //             if(value.trim() != _newPassword.text.trim()) return "Les deux mot de passe ne correspondent pas !";
        //             return null;
        //           },
        //           inputFormatters: [
        //             // WhitelistingTextInputFormatter.digitsOnly,
        //             // new LengthLimitingTextInputFormatter(19),
        //             // new CardNumberInputFormatter()
        //             // FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),

        //           ],
        //           decoration: InputDecoration(
        //             prefixIcon: Icon(LineAwesomeIcons.lock),
        //             floatingLabelBehavior: FloatingLabelBehavior.auto,
        //             labelText:  'répéter le mot de passe',
        //             border: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(15.0)
        //             ),
        //             filled: true,
        //             contentPadding: EdgeInsets.fromLTRB(12, 2, 12, 2),
        //             fillColor: Colors.grey[100],
        //             focusedBorder: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(15.0),
        //               borderSide: BorderSide(
        //                 width: 1.0,
        //                 color: ctColor2
        //               ),
        //             ),
        //             enabledBorder:  OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(15.0),
        //               borderSide: BorderSide(
        //                 width: 1.0,
        //                 color: Colors.grey[400]
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //       SizedBox(height: 10.0,),
        //       Row(
        //         children: [
        //           Expanded(
        //             child: CupertinoButton(
        //               padding: EdgeInsets.zero,
        //               child: Container(
        //                 height: 40.0,
        //               //  width: 200.0,
        //                 decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(15.0),
        //                   color: _formKey.currentState != null 
        //                     && _formKey.currentState.validate() == true
        //                     ? ctColor2
        //                     : Theme.of(context).disabledColor
        //                 ),
        //                 child: Center(
        //                   child: Text(
        //                     "Valider",
        //                     style: TextStyle(
        //                       color: ctColor1
        //                     ),
        //                   ),
        //                 ),
        //               ), 
        //               onPressed: _formKey.currentState != null 
        //                 && _formKey.currentState.validate() == true
        //                 ? (){}
        //                 :null
        //             ),
        //           )
        //         ],
        //       ),
        //       SizedBox(height: 10.0,),

        //     ],
        //   )
        // ),

      ],
    );
  }

  void _showBottomSheet({BuildContext context}){
    showModalBottomSheet(
      context: context, 
      builder: (_){
        return Container(
          height: 0.2 * MediaQuery.of(context).size.height,
          color: Color(0xFF737373),
          child: Container(
            decoration: BoxDecoration(
              // color: ctColor10,
              borderRadius: BorderRadius.circular(15.0)
            ),
            child: Column(
              children: [ 
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: ctColor10,
                    borderRadius: BorderRadius.circular(15.0)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Material(
                      type: MaterialType.transparency,
                      child: ListTile(
                        leading: Icon(Icons.photo_camera),
                        onTap: (){
                          Navigator.of(context).pop();
                          _captureImage();
                        },
                        title: Text(
                          "Prendre une photo"
                        ),
                        trailing: Icon(LineAwesomeIcons.arrow_right),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.0,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: ctColor10,
                    borderRadius: BorderRadius.circular(15.0)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Material(
                      type: MaterialType.transparency,
                      child: ListTile(
                        onTap: (){
                          Navigator.of(context).pop();
                          _browseImage();
                        },
                        leading: Icon(Icons.photo_library),
                        title: Text(
                          "Choisir une photo"
                        ),
                        trailing: Icon(LineAwesomeIcons.arrow_right),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }


  final _keyLoader  = GlobalKey<State>();
  final _dbHelper = UserDbHelper();
  void _updateProfilPic({dynamic pic,dynamic picname,Uint8List localpic}) async {
    try {
      EndpointDataModel _result = await httpHelper.postUrl(
        header: {
          "appversion":"${userBloc.appVersion}",
          "cache-control":"no-cache"
        },
        link: "$ctMainLink/experts/update-profil-pic",
        body: {
          "token":"${userBloc.userBlocDataModel.usertoken}",
          "pic":"$pic",
          "picname":"$picname"
        }
      );
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
      if(_result.error != null){
        if(_result.error is SocketException){
          appShowMessageDialog(
            context: context,
            title: "Message",
            message: "Echec de l'opération, veuillez vérifier votre connexion internet"
          );
        } else {
          appShowMessageDialog(
            context: context,
            title: "Message",
            message: "Echec de l'opération, veuillez réessayer ultérieurement"
          );
        }
      } else {
        Map<String,dynamic> _response = _result.data;
        if(_response.containsKey('status') && _response['status'] == true){
          //update user in db
          bool _saved = await saveImageFileLocally(bytes: localpic,filename: "user_profil_pic.png");
          if(_saved){
            var _imageName = "user_profil_pic.png";
            UserDataModel _user = UserDataModel(picture:_imageName);
            final _update = await _dbHelper.updateUser(user: _user);
            if(_update > 0) {
              userBloc.loadUserInfo();
              Future.delayed(Duration(milliseconds: 300),(){
                setState(() {});
              });
            }
          }
        } else if(_response.containsKey('status') && _response['status']== false){
          appShowMessageDialog(
            context: context,
            title: "Message",
            message:_response['message']??"Echec de l'opération, veuillez réessayer ultérieurement",
          ); 
        } else {
          appShowMessageDialog(
            context: context,
            title: "Message",
            message: "Echec de l'opération, veuillez réessayer ultérieurement"
          );
        }
      }

    } catch(e){
      print("error :::: $e");
      Scaffold.of(_ctx)
        .showSnackBar(SnackBar(
          content: Text("Echec de l'opération",style: TextStyle(color: ctColor1),),
          backgroundColor: ctColor2,
        ));
    }
  }

  final imagePicker = ImagePicker();
  Future _browseImage() async {
    try{
      imagePicker.getImage(source: ImageSource.gallery).then((img) async{
        if(img !=null) {
          var _img = await img.readAsBytes();
          var _image = img.path;
          var _imageB64 = base64Encode(_img);
          // print("IMAGE :: $_image");
          BusyDialog.showLoadingDialog(context: context,key: _keyLoader,);
          Future.delayed(Duration(milliseconds: 500),(){ 
            _updateProfilPic(pic: _imageB64,picname: _image,localpic:_img);
          });
        }
        setState(() {});
      }).catchError((err) {});
    } catch(e){}

  }

  Future _captureImage() async {
    imagePicker.getImage(source: ImageSource.camera).then((img) async {
      if(img !=null) {
        var _img = await img.readAsBytes();
        var _image = img.path;
        var _imageB64 = base64Encode(_img);
        // print("IMAGE :: $_image");
        BusyDialog.showLoadingDialog(context: context,key: _keyLoader,);
        Future.delayed(Duration(milliseconds: 500),(){ 
          _updateProfilPic(pic: _imageB64,picname: _image,localpic:_img);
        });
      }
      setState(() {});
    }).catchError((err) {});
  }
}