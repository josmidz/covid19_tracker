
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:covid19_tracker/blocs/app_event.dart';
import 'package:covid19_tracker/blocs/base_bloc.dart';
import 'package:covid19_tracker/datasource/db/user_db_helper.dart';
import 'package:covid19_tracker/datasource/http/http_helper.dart';
import 'package:covid19_tracker/datasource/http/main_link.dart';
import 'package:covid19_tracker/utils/save_file_helper.dart';

class UserBloc extends BlocBase {
  StreamController<UserBlocDataModel> _userStreamController = StreamController<UserBlocDataModel>.broadcast();
  Stream<UserBlocDataModel> get userStream => _userStreamController.stream;

  StreamController<UserCovidBlocDataModel> _userCovidStreamController = StreamController<UserCovidBlocDataModel>.broadcast();
  Stream<UserCovidBlocDataModel> get userCovidStream => _userCovidStreamController.stream;

  AppEvent _appEvent = NoState();

  AppEvent _appUserCovidEvent = NoState();

  //---
  List<UserCovidDataModel> _listUserCovidInfo = <UserCovidDataModel>[];
  List<UserCovidDataModel> get listUserCovidInfo => _listUserCovidInfo;

  UserDataModel _userBlocDataModel = UserDataModel();
  UserDataModel get userBlocDataModel => _userBlocDataModel;
  //--
  int appVersion = 0;
  dynamic registerToken = "";

  //covid
  dynamic nouveauCas = 0;
  dynamic gueris     = 0;
  dynamic deces      = 0;

  @override
  void dispose() {
    _userStreamController.close();
    _userCovidStreamController.close();
  }

  void assignUser({UserDataModel udataModel}){
    _userBlocDataModel = udataModel ??_userBlocDataModel;
    _assignState();
  }

  final _dbHelper = UserDbHelper();
  void loadUserInfo() async {
    final udb = await _dbHelper.getUserInfo();
    if(udb.usertoken != null){
      LocalFileModel _localFileModel 
        = await loadLocalfiles(flag: udb.countryflag,photo: udb.picture);

      UserDataModel _last 
      = UserDataModel.fromMap(map:{...udb.toMap(),...{
        countryFlagBytesColumn:_localFileModel.flag,
        userPhotoBytesColumn:_localFileModel.photo}});
      
      //ASSIGN TO BLOC
      assignUser(udataModel:_last);
    } else {
      assignUser(udataModel:UserDataModel());
    }
  }

  Future<bool> userLogOut() async {
    List<UserDataModel> _users = await _dbHelper.getUsers();
    if(_users.length > 0){
      for (var item in _users) {
        await _dbHelper.deleteUser(item.dbid);
      }
      assignUser(udataModel:UserDataModel());
      return true;
    } else {
      assignUser(udataModel:UserDataModel());
      return true;
    }
  }

  void _assignState({AppEvent appEvent}){
    _appEvent = appEvent ?? _appEvent;
    if(_userStreamController.isClosed){
      _userStreamController = StreamController<UserBlocDataModel>.broadcast();
      _userStreamController.sink.add(UserBlocDataModel(
        appEvent: _appEvent,
        userDataModel:  _userBlocDataModel
      ));
    } else {
      _userStreamController.sink.add(UserBlocDataModel(
        appEvent: _appEvent,
        userDataModel:  _userBlocDataModel
      ));
    }
  }
  
  void assignUserCovidState({AppEvent appUserCovidEvent,UserCovidDataModel userCovidDataModel}){
    _appUserCovidEvent = appUserCovidEvent ?? _appUserCovidEvent;
    if(_userCovidStreamController.isClosed){
      _userCovidStreamController = StreamController<UserCovidBlocDataModel>.broadcast();
      _userCovidStreamController.sink.add(UserCovidBlocDataModel(
        appUserCovidEvent: _appUserCovidEvent,
        listUserCovidInfo: userCovidDataModel??  _listUserCovidInfo
      ));
      if(userCovidDataModel !=null)
        loadUserCovid();
    } else {
      _userCovidStreamController.sink.add(UserCovidBlocDataModel(
        appUserCovidEvent: _appUserCovidEvent,
        listUserCovidInfo: userCovidDataModel?? _listUserCovidInfo
      ));
      if(userCovidDataModel !=null)
        loadUserCovid();
    }
  }


  
  void loadUserCovid() async {
    assignUserCovidState(appUserCovidEvent: LoadingState());
    try {
      EndpointDataModel result = await httpHelper.getUrl(
        header: {
          "Content-Type":"application/json",
          'cache-control':'no-cache',
          "app-version":"$appVersion"
        },
        link: "$ctMainLink/experts/covid-info/${_userBlocDataModel.usertoken}"
      );
      if(result.error !=null ) {
        if(result.error is SocketException){
          assignUserCovidState(appUserCovidEvent: NoNetworkState());
        } else {
          assignUserCovidState(appUserCovidEvent: FailState());
        }
      } else {
        Map<String,dynamic> _res = result.data;
        if(_res.containsKey('status') 
          && _res['status'] == true){
            _listUserCovidInfo.clear();
            var _data = _res['data'];
          for (var i = 0; i < _data.length; i++) {
            _listUserCovidInfo.add(UserCovidDataModel(
              categoryname: _data[i]['categoryname'],
              categoryid: _data[i]['categoryid'],
              covidinfo:  _data[i]['covidinfo'],
              id  :  _data[i]['id'],
            ));
          }
          assignUserCovidState(appUserCovidEvent: LoadedState());
        } else if(_res.containsKey('status') 
          && _res['status'] == false){
            var _message = _res['message'];
            assignUserCovidState(appUserCovidEvent: FailWithMessageState(message:_message ));
        } else {
          assignUserCovidState(appUserCovidEvent: FailState());
        }
      }
    } catch(e){
      assignUserCovidState(appUserCovidEvent: FailState());
    }
  }
}

final UserBloc userBloc = UserBloc();

class UserCovidDataModel {
  dynamic categoryname;
  dynamic categoryid;
  dynamic covidinfo;
  dynamic id;
  UserCovidDataModel({this.categoryname,this.categoryid,this.covidinfo,this.id});
}

class UserCovidBlocDataModel {
  AppEvent appUserCovidEvent;
  List<UserCovidDataModel> listUserCovidInfo;
  UserCovidBlocDataModel({this.appUserCovidEvent,this.listUserCovidInfo = const[]});
}

class UserBlocDataModel {
  AppEvent appEvent;
  UserDataModel userDataModel;
  UserBlocDataModel({this.appEvent,this.userDataModel});
}

//DB FIELD
String userTableName  = "usertable";
String useridColumn    = "_userid";
String prenomColumn   = "prenom";
String tokenColumn   = "usertoken";
String nomColumn      = "nom";
String emailColumn    = "email";
String pictureColumn  = "picture";
String countryNameColumn  = "countryname";
String countryIdColumn  = "countryid";
String countryFlagColumn  = "countryflag";
String countryCodeColumn  = "countrycode";
String countryNatColumn   = "countrynat";

String countryFlagBytesColumn   = "countryflagbytes";
String userPhotoBytesColumn   = "userphotobytes";


class UserDataModel {
  int dbid;
  String usertoken;
  String prenom;
  String nom;
  String email;
  String picture;
  Uint8List userPicBytes;
  Uint8List countryflagBytes;
  String countryname;
  String countryflag;
  String countrycode;
  String countryid;
  String countrynat;
  UserDataModel({this.countryflagBytes,this.userPicBytes, this.countrynat,this.dbid,this.countrycode,this.countryflag,this.countryname,this.countryid,this.picture,this.usertoken,this.email,this.nom,this.prenom});

  @override
  String toString(){
    return 'UserDataModel{dbid: $dbid, usertoken: $usertoken, prenom: $prenom,email: $email , countryid: $countryid, countryflag: $countryflag, picture: $picture, countryflagBytes: $countryflagBytes, }';
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = {
      prenomColumn        : prenom,
      nomColumn           : nom,
      tokenColumn         : usertoken,
      emailColumn         : email,
      pictureColumn       : picture,
      countryIdColumn     : countryid,
      countryNameColumn   : countryname,
      countryNatColumn    : countrynat,
      countryCodeColumn   : countrycode,
      countryFlagColumn   : countryflag
    };
    if(dbid !=null)
      map[useridColumn] = dbid;
    
    return map;
  }

  Map<String,dynamic> toMapForUpdate(){
    Map<String,dynamic> map = {};
    if(countryflag !=null)
      map[countryFlagColumn] = countryflag;
    if(countrycode !=null)
      map[countryCodeColumn] = countrycode;
    if(countrynat !=null)
      map[countryNatColumn] = countrynat;
    if(countryname !=null)
      map[countryNameColumn] = countryname;
    if(countryid !=null)
      map[countryIdColumn] = countryid;
    if(picture !=null)
      map[pictureColumn] = picture;
    if(email !=null)
      map[emailColumn] = email;
    if(usertoken !=null)
      map[tokenColumn] = usertoken;
    if(nom !=null)
      map[nomColumn] = nom;
    if(prenom !=null)
      map[prenomColumn] = prenom;
    if(dbid !=null)
      map[useridColumn] = dbid;
    return map;
  }

  // UserDataModel toDataModels(){
  //   return this;
  // }

  UserDataModel toDataModel(){
    return UserDataModel()
      ..nom = nom
      ..prenom = prenom
      ..picture = picture
      ..usertoken = usertoken
      ..email = email
      ..countryid= countryid
      ..countryname = countryname
      ..countryflag = countryflag
      ..countrycode = countrycode
      ..countrynat = countrynat
      ..dbid = dbid
      ..countryflagBytes = countryflagBytes
      ..userPicBytes = userPicBytes;
  }

  UserDataModel.fromMap({Map<String,dynamic> map}){
    prenom      = map[prenomColumn];
    nom         = map[nomColumn];
    email       = map[emailColumn];
    dbid        = map[useridColumn];
    usertoken   = map[tokenColumn];
    picture     = map[pictureColumn];
    countryid   = map[countryIdColumn];
    countryname = map[countryNameColumn];
    countryflag = map[countryFlagColumn];
    countrycode = map[countryCodeColumn];
    dbid        = map[useridColumn];
    countryflagBytes = map[countryFlagBytesColumn];
    userPicBytes     = map[userPhotoBytesColumn];
  }

  UserDataModel.fromDataModel({UserDataModel dataModel}) {
    if(dataModel.prenom != null)
      prenom      = dataModel.prenom;
    if(dataModel.nom != null)
      nom         = dataModel.nom;
    if(dataModel.email !=null)
      email       = dataModel.email;
    if(dataModel.dbid != null)
      dbid        = dataModel.dbid;
    if(dataModel.usertoken != null)
      usertoken   = dataModel.usertoken;
    if(dataModel.picture != null)
      picture     = dataModel.picture;
    if(dataModel.countryid != null)
      countryid   = dataModel.countryid;
    if(dataModel.countryname != null)
      countryname = dataModel.countryname;
    if(dataModel.countryflag != null)
      countryflag = dataModel.countryflag;
    if(dataModel.countrycode != null)
      countrycode = dataModel.countrycode;
    if(dataModel.countrynat != null)
      countrynat = dataModel.countrynat;
  }
}