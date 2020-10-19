
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  
  Future<EndpointDataModel> postUrl({dynamic body, header,dynamic link}) async {
    EndpointDataModel _data = EndpointDataModel();
    try {
      var response = await 
      http.post(Uri.encodeFull(
        '$link'),body: body,headers: header);
      _data.data = json.decode(response.body);
      return _data;
    } catch (e) {
      _data.error = e;
      return _data;
    }
    
  }

  Future<EndpointDataModel> putUrl({dynamic body, header,dynamic link}) async {
    EndpointDataModel _data = EndpointDataModel();
    try {
      var response = await 
      http.put(Uri.encodeFull(
        '$link'),body: body,headers: header);
      _data.data = json.decode(response.body);
      return _data;
    } catch (e) {
      _data.error = e;
      return _data;
    }
    
  }

  Future<EndpointDataModel> getUrl({dynamic header,dynamic link}) async {
    EndpointDataModel _data = EndpointDataModel();
    try {
      var response = await http.get(Uri.encodeFull(
        '$link'),headers: header);
      // print("BODY :: ${response.body}");
      _data.data = json.decode(response.body);
      return _data;
    } on PlatformException catch (e) {
      _data.error = e;
      return _data;
    } on FormatException{
      _data.error = "error";
      return _data;
    } catch (e) {
      _data.error = e;
      return _data;
    } 
  }

}

HttpHelper httpHelper = HttpHelper();

class EndpointDataModel {
  dynamic error;
  dynamic data;
  EndpointDataModel({this.data,this.error});
}
