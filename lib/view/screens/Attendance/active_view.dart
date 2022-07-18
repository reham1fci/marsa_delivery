
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/utill/app_images.dart';
import 'package:marsa_delivery/view/base/EditText.dart';
import 'package:marsa_delivery/view/base/alert_dialog.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';
import 'package:marsa_delivery/view/base/get_current_location.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ActiveView extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ActiveState();
  }

}
class ActiveState extends State<ActiveView> {
  Api api = Api() ;
  CurrentLoc currentLoc  = CurrentLoc() ;
late User user  ;
 late SharedPreferences shared ;
  Timer? timer ;

  List<DateTime> _events = [];
  Location location = new Location();
  LocationData? currentLocation ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData() ;
   // initPlatformState() ;
  }
  trackLocation() async{
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    location.enableBackgroundMode(enable: true) ;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    const oneSec = Duration(minutes: 5);
    timer  =  Timer.periodic(oneSec, (Timer t) async {
      _locationData = await location.getLocation();

      print(_locationData);
      print(_locationData.latitude);
      print(_locationData.longitude);

      getLocation(_locationData) ;

      //   updateToDb(newData);

    });
   // location.changeSettings(interval: 50000 ,) ;
  /*  location.onLocationChanged.listen((LocationData currentLocation) {
     this.currentLocation  = currentLocation;
      // Use current location

    });*/
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            iconTheme:  const IconThemeData(color: AppColors.appBarIcon),
            systemOverlayStyle:const SystemUiOverlayStyle(
              // Status bar color

              statusBarColor: AppColors.statusAppBar,)),
          //  backgroundColor: AppColors.appBar,title:Text( getTranslated("active", context)??"",style: const TextStyle(color: AppColors.logRed),) ),
        body: Container(
          height: double.infinity,
          padding:  EdgeInsets.all(15) , child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        //  Padding(padding: EdgeInsets.all(10) , child:  Text(getTranslated("active_title", context)??"", style: TextStyle(color: AppColors.logRed ,fontSize: 18),) ) ,
            Padding(padding: const EdgeInsets.only(bottom: 50.0 ,top: 50) , child: Image.asset(Images.location2 )),

            Padding(padding: EdgeInsets.all(10) , child:   Text(getTranslated("track_location", context)??"" , style: TextStyle(fontSize: 18) )),
      Spacer() ,
            Row(children: [
              CustomBtn(buttonNm: getTranslated("allow", context)??"", backBtn: AppColors.white, txtColor: AppColors.logRed, onClick:confirmBtn),
              Spacer() ,

              CustomBtn(buttonNm: getTranslated("deny", context)??"", backBtn: AppColors.white, txtColor: AppColors.logRed, onClick:(){
                Navigator.of(context).pop();

              }),

            ],)
          ],),
        )) ;
  }
confirmBtn() async {
   shared.setString("attend", "active");
   //trackLocationBackGround(user)
//trackLocationWithFetch();
  trackLocation();
   CustomDialog.dialog(context: context,
       title: "",
       message: getTranslated("active_title", context)??"",
       onOkClick: (){
         Navigator.of(context).pop();

       },
       isCancelBtn: false);
}
  onLocationAdded( var jsonObj){
    print(jsonObj) ;
  }
  onError(String err){
    print(err) ;
  }
   getUserData() async{
      shared = await SharedPreferences.getInstance();
     user = User.fromJsonShared(json.decode(shared.getString("user")!));

   }

  getLocation(LocationData location){
       user.lat  = location.latitude.toString() ;
       user.lng  = location.longitude.toString() ;
      user.createLocation  = Api.getDate('yyyy-MM-dd  H:m:s aa') ;
      api.request(url: Constants.getDriverLocation, map: user.addLocationToMap(), onSuccess: onLocationAdded, onError: onError) ;


  }
     void stopTimer(){
    timer?.cancel()  ;
  }
}