
import 'dart:async';
import 'dart:io';

import 'package:covid19_tracker/blocs/app_event.dart';
import 'package:covid19_tracker/blocs/base_bloc.dart';
import 'package:covid19_tracker/blocs/user/user_bloc.dart';
import 'package:covid19_tracker/datasource/http/http_helper.dart';
import 'package:covid19_tracker/datasource/http/main_link.dart';

class CovidBloc extends BlocBase{
  StreamController<CovidBlocDataModel> _covidStreamController = StreamController<CovidBlocDataModel>.broadcast();
  Stream<CovidBlocDataModel> get covidStream => _covidStreamController.stream;

  AppEvent _appEvent = NoState();
  List<CovidInfoDataModel> _listCovidInfo = [];
  List<CovidInfoDataModel> get listCovidInfo =>_listCovidInfo;



  @override
  void dispose() {
    _covidStreamController.close();
  }

  void fetchCovidInfo() async {
    _assignCovidState(appEvent: LoadingState());
    try {
      EndpointDataModel result = await httpHelper.getUrl(
        header: {
          "Content-Type":"application/json",
          'cache-control':'no-cache',
          "app-version":"${userBloc.appVersion}"
        },
        link: "$ctMainLink/covid-info/all"
      );
      if(result.error !=null ) {
        if(result.error is SocketException){
          _assignCovidState(appEvent: NoNetworkState());
        } else {
          _assignCovidState(appEvent: FailState());
        }
      } else {
        Map<String,dynamic> _res = result.data;
        if(_res.containsKey('status') 
          && _res['status'] == true){
            _listCovidInfo.clear();
            List<dynamic> _list = _res['data'];
            for(var i=0;i<_list.length;i++){
              var _el = _list[i];
              _listCovidInfo.add(
                CovidInfoDataModel(
                  idCategory: _el['idcategory'],
                  category: _el['category'],
                  genValue:  _el['genvalue'],
                  info:  <CovidChildInfoDataModel>[],
                )
              );
              for(var j=0; j <_el['info'].length;j++){
                var _elem = _el['info'][j];
                _listCovidInfo[i].info.add(
                  CovidChildInfoDataModel(
                    country: CovidCountry(
                      countryname: _elem['country']['countryname'],
                      countryflag    : _elem['country']['countryflag'],
                    ),
                    expert: CovidExpert(
                      fullname  : _elem['expert']['fullname'],
                      photo     : _elem['expert']['photo'],
                      nationality     : _elem['expert']['nationality'],
                    ),
                    stats: <CovidStats>[],
                  )
                );
                for(var k=0; k <_el['info'][j]['stats'];k++){
                  var _element =_el['info'][j]['stats'][k];
                  _listCovidInfo[i].info[j].stats.add(
                    CovidStats(
                      value: _element['value'],
                      categoryname: _element['categoryname'],
                      categoryid: _element['categoryid'],
                    )
                  );
                }
              }
            }
          _assignCovidState(appEvent: LoadedState());
        } else if(_res.containsKey('status') 
          && _res['status'] == false){
            var _message = _res['message'];
            _assignCovidState(appEvent: FailWithMessageState(message:_message ));
        } else {
          _assignCovidState(appEvent: FailState());
        }
      }
    } catch(e){
      _assignCovidState(appEvent: FailState());
    }
  }

  void _assignCovidState({AppEvent appEvent}){
    _appEvent = appEvent ?? _appEvent;
    if(_covidStreamController.isClosed){
      _covidStreamController = StreamController<CovidBlocDataModel>.broadcast();
      _covidStreamController.sink.add(CovidBlocDataModel(
        appEvent: _appEvent,
        listCovidInfo:  _listCovidInfo
      ));
    } else {
      _covidStreamController.sink.add(CovidBlocDataModel(
        appEvent: _appEvent,
        listCovidInfo:  _listCovidInfo
      ));
    }
  }
  
}

final CovidBloc covidBloc  = CovidBloc();

class CovidBlocDataModel {
  AppEvent appEvent;
  List<CovidInfoDataModel> listCovidInfo;
  CovidBlocDataModel({this.appEvent,this.listCovidInfo =const[]});
}

class CovidInfoDataModel {
  dynamic idCategory;
  dynamic category;
  dynamic genValue;
  List<CovidChildInfoDataModel> info;
  CovidInfoDataModel({this.category,this.info = const[],this.idCategory,this.genValue});
}

class CovidChildInfoDataModel {
  CovidCountry country;
  CovidExpert expert;
  List<CovidStats> stats;
  CovidChildInfoDataModel({this.country,this.expert,this.stats = const[]});
}

class CovidCountry {
  final countryname;
  final countryflag;
  final nationality;
  CovidCountry({this.countryname,this.countryflag,this.nationality});
}

class CovidExpert{
  final fullname;
  final photo;
  final nationality;
  CovidExpert({this.fullname,this.photo,this.nationality});
}

class CovidStats {
  final categoryname;
  final value;
  final categoryid;
  CovidStats({this.categoryname,this.value,this.categoryid});
}

