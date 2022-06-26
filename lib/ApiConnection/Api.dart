
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'  as http ;
import 'package:connectivity/connectivity.dart';
import 'package:intl/intl.dart';


class Api {
  Future request({
    required String url ,
    required Map  map ,
    required Function  onSuccess  ,
    required Function onError }  )async{
    print(map) ;
    await http.post(Uri.parse(url) ,body  : map  ) .then((http.Response response) {
      print(response.statusCode);
      if(response.statusCode == 200) {
      //var jsonStr = json.decode(response.body);
     //    print(jsonStr) ;
      onSuccess(response.body) ;

      }
      else {
        onError("Connection Error") ;
        return null ;
      }

    }
      );

  }
  Future request2({
  required String url ,
  required Map  map ,
  required Function  onSuccess  ,
  required Function onError }  )async{
  print(map) ;
  print(jsonEncode(map)) ;
  await http.post(Uri.parse(url) ,body  : jsonEncode(map)  , headers: {"Content-Type": "application/json"} ) .then((http.Response response) {
  if(response.statusCode == 200) {
  var jsonStr = json.decode(response.body);
  print(jsonStr) ;
  onSuccess(response.body) ;
  }
  else {
  onError("Connection Error") ;
  return null ;
  }

  }
  );

  }


  Future getRequest({
    required String url ,
    required Function  onSuccess  ,
    required Function onError}  )async{
    await http.get(Uri.parse(url)  ) .then((http.Response response) {
      if(response.statusCode == 200) {
      var jsonStr = json.decode(response.body);
         print(jsonStr) ;
      onSuccess(response.body) ;
      }
      else {
        onError("Connection Error") ;
        return null ;
      }

    }
      );

  }
  Future<bool> checkInternet({required Function onConnect ,required Function notConnect}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      onConnect() ;
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      onConnect() ;

      return true;
    }
    notConnect();
    return false;
  }



static String getDate(String format){
  var now =  DateTime.now();
  var formatter =  DateFormat(format);
  String formattedDate = formatter.format(now);
  print(formattedDate); // 2016-01-25
  return formattedDate  ;
}}