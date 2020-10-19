
import 'dart:async';
import 'dart:io';

import 'package:covid19_tracker/blocs/app_event.dart';
import 'package:covid19_tracker/blocs/base_bloc.dart';
import 'package:covid19_tracker/blocs/user/user_bloc.dart';
import 'package:covid19_tracker/datasource/http/http_helper.dart';
import 'package:covid19_tracker/datasource/http/main_link.dart';
import 'package:equatable/equatable.dart';

class CountryBloc extends BlocBase {
  StreamController<CountryBlocData> _countryStreamController = StreamController<CountryBlocData>.broadcast();
  Stream<CountryBlocData> get countryStream => _countryStreamController.stream;

  AppEvent _appEvent = NoState();
  List<CountryDataModel> _listCountries = [];

  @override
  void dispose() {
    _countryStreamController.close();
  }

  void fetchCountries() async{
    _assignState(appEvent: LoadingState());
    try {
      EndpointDataModel result = await httpHelper.getUrl(
        header: {
          "Content-Type":"application/json",
          'cache-control':'no-cache',
          "app-version":"${userBloc.appVersion}"
        },
        link: "$ctMainLink/countries"
      );
      if(result.error !=null ) {
        if(result.error is SocketException){
          _assignState(appEvent: NoNetworkState());
        } else {
          _assignState(appEvent: FailState());
        }
      } else {
        Map<String,dynamic> _res = result.data;
        if(_res.containsKey('status') 
          && _res['status'] == true){
            _listCountries.clear();
            List<dynamic> _list = _res['data'];
            for(var i=0;i<_list.length;i++){
              _listCountries.add(
                CountryDataModel(
                  countrycode: _list[i]['code'],
                  countryflag: _list[i]['flag'],
                  countryid: _list[i]['_id'],
                  countryname: _list[i]['country'],
                  countrynat: _list[i]['nationality'],
                )
              );
            }
          _assignState(appEvent: LoadedState());
        } else if(_res.containsKey('status') 
          && _res['status'] == false){
            var _message = _res['message'];
            _assignState(appEvent: FailWithMessageState(message:_message ));
        } else {
          _assignState(appEvent: FailState());
        }
      }
    } catch(e){
      _assignState(appEvent: FailState());
    }
  }


  void _assignState({AppEvent appEvent}){
    _appEvent = appEvent ?? _appEvent;
    if(_countryStreamController.isClosed){
      _countryStreamController = StreamController<CountryBlocData>.broadcast();
      _countryStreamController.sink.add(CountryBlocData(
        appEvent: _appEvent,
        listCountries:  _listCountries
      ));
    } else {
      _countryStreamController.sink.add(CountryBlocData(
        appEvent: _appEvent,
        listCountries:  _listCountries
      ));
    }
  }
  
}

final countryBloc = CountryBloc();

class  CountryBlocData {
  AppEvent appEvent;
  List<CountryDataModel> listCountries;
  CountryBlocData({this.appEvent,this.listCountries =const[]});
}


class CountryDataModel extends Equatable {
  final countryname;
  final countryid;
  final countrycode;
  final countryflag;
  final countrynat;
  CountryDataModel({this.countryid, this.countrycode,this.countryflag,this.countryname,this.countrynat});
  @override
  List<Object> get props => [countryname,countryid,countrycode,countryflag,countrynat];
  
}