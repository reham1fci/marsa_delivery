import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/utill/app_strings.dart';
import 'package:marsa_delivery/view/base/drawer.dart';
import 'package:marsa_delivery/view/base/get_current_location.dart';
import 'package:marsa_delivery/view/screens/main_screen/widgets/pi_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainBody extends StatefulWidget{
  const MainBody({Key? key}) : super(key: key);

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  CurrentLoc currentLoc  = CurrentLoc() ;
  Api api = Api() ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
getUserData() ;

  }
  getUserData() async {
    SharedPreferences  shared = await SharedPreferences.getInstance();
   User user = User.fromJsonShared(json.decode(shared.getString("user")!));


    currentLoc.getCurrentLocation(onGetLocation:(lat , lng){
      print(lat);
      print(lng)  ;

user.lat  = lat.toString() ;
user.lng  = lng.toString() ;
user.createLocation  = Api.getDate('yyyy-MM-dd  H:m:s aa') ;
api.request(url: Constants.getDriverLocation, map: user.addLocationToMap(), onSuccess: onLocationAdded, onError: onError) ;

    } );

  }

   onLocationAdded( var jsonObj){
    print(jsonObj) ;
   }
   onError(String err){
    print(err) ;
   }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
return Scaffold(
  appBar: AppBar(
    backgroundColor: AppColors.colorPrimary  ,
      title: Text(getTranslated(Strings.appName, context)??"")),
  body:  Center(
    child:PiChart(),
  ),
  drawer: AppDrawer(),
) ; }
}