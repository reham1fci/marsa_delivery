
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/utill/app_images.dart';
import 'package:marsa_delivery/view/base/drawer_header.dart';
import 'package:marsa_delivery/view/base/drawer_item.dart';
import 'package:marsa_delivery/view/base/drawer_sub_button.dart';
import 'package:marsa_delivery/view/screens/clients/add_client_view.dart';
import 'package:marsa_delivery/view/screens/login/login_view.dart';
import 'package:marsa_delivery/view/screens/main_screen/widgets/add_%20daily_distance_dialog.dart';
import 'package:marsa_delivery/view/screens/main_screen/widgets/language.dart';
import 'package:marsa_delivery/view/screens/points_sale/add_clients_view.dart';
import 'package:marsa_delivery/view/screens/points_sale/show_clients_view.dart';
import 'package:marsa_delivery/view/screens/profile/profile_view.dart';
import 'package:marsa_delivery/view/screens/receipt_delivery/delivery_view.dart';
import 'package:marsa_delivery/view/screens/receipt_delivery/quantity_view.dart';
import 'package:marsa_delivery/view/screens/receipt_delivery/receipt_shipment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'alert_dialog.dart';
import 'get_current_location.dart';
class AppDrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return DrawerState();
  }

}
class DrawerState extends State<AppDrawer> {

  late SharedPreferences  shared  ;
String userName= ""  ;
String? textAttBtn= "";
  bool _enabled = true;
  int _status = 0;
  List<DateTime> _events = [];
  CurrentLoc currentLoc  = CurrentLoc() ;
  Api api = Api() ;
 late User  user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData() ;
  //  initPlatformState();
  }
  attendanceClick(){
  setState(() {
    if(shared.getString("attend")=="attendance") {
      textAttBtn = "leave";
      shared.setString("attend", "leave");
    }});
 /* BackgroundFetch.start().then((int status) {
    print('[BackgroundFetch] start success: $status');
  }).catchError((e) {
    print('[BackgroundFetch] start FAILURE: $e');
  });
  bg.BackgroundGeolocation.onLocation((bg.Location location) {
    print('[location] - $location');
    user.lat  = location.coords.latitude.toString() +"l";
    user.lng  = location.coords.longitude.toString() +"l";
    user.createLocation  = Api.getDate('yyyy-MM-dd  H:m:s aa') ;
    api.request(url: Constants.getDriverLocation, map: user.addLocationToMap(), onSuccess: onLocationAdded, onError: onError) ;

    //CustomDialog.dialog(context: context, title: " location", message: "lat :"+user.lat .toString() +"lng :"+user.lng .toString()+"\n"+  user.createLocation! , isCancelBtn: false) ;

  });

  // Fired whenever the plugin changes motion-state (stationary->moving and vice-versa)
  bg.BackgroundGeolocation.onMotionChange((bg.Location location) {
    print('[motionchange] - $location');
   // locatio
    user.lat  = location.coords.latitude.toString()+"m" ;
    user.lng  = location.coords.longitude.toString()+"m" ;
    user.createLocation  = Api.getDate('yyyy-MM-dd  H:m:s aa') ;
  //  print (time);
    api.request(url: Constants.getDriverLocation, map: user.addLocationToMap(), onSuccess: onLocationAdded, onError: onError) ;
  //  CustomDialog.dialog(context: context, title: "monitor location", message: "lat :"+user.lat .toString() +"lng :"+user.lng .toString()+"\n"+  user.createLocation! , isCancelBtn: false) ;


  });

  // Fired whenever the state of location-services changes.  Always fired at boot
  bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
    print('[providerchange] - $event');
  });

  ////
  // 2.  Configure the plugin

  bg.BackgroundGeolocation.ready(bg.Config(
      desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
      distanceFilter:10,
      stopOnTerminate: false,
      startOnBoot: true,
      debug: true,
      logLevel: bg.Config.LOG_LEVEL_VERBOSE
  )).then((bg.State state) {
    if (!state.enabled) {
      ////
      // 3.  Start the plugin.
      //
      bg.BackgroundGeolocation.start();
    }
  });
    }else{
      addDistance();
     // textAttBtn = "attendance";
     // shared.setString("attend", "attendance") ;

    }
  });*/
  }
  onLocationAdded( var jsonObj){
    print(jsonObj) ;
  }
  onError(String err){
    print(err) ;
  }
  getUserData() async {
      shared = await SharedPreferences.getInstance();
      setState(() {
        if(shared.containsKey("attend")) {
          textAttBtn = shared.getString("attend");
        }
        else{
          textAttBtn = "attendance" ;
          shared.setString("attend", "attendance") ;
        }
      });

      user = User.fromJsonShared(json.decode(shared.getString("user")!));
 setState(() {
   userName  = user.name!  ;
 });

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Drawer(

     // Add a ListView to the drawer. This ensures the user can scroll
     // through the options in the drawer if there isn't enough vertical
     // space to fit everything.
     child:
         Container
           ( 
      //   color:AppColors.colorPrimary ,
         child:
     ListView(
       // Important: Remove any padding from the ListView.
       padding: EdgeInsets.zero,
       children: [
         AppDrawerHeader(userName),
         DrawerItem(icon:const Icon(Icons.person , color: AppColors.appBarIcon), text:"profile", onTap: (){
    Navigator.pushReplacement( context,
    MaterialPageRoute(builder: (context) => const ProfileView())) ;
         }),

         DrawerItem(icon:Image.asset(Images.performance,width: 20,height: 20,color: AppColors.appBarIcon,), text: "performance", onTap: (){}),
        //const  Divider(color: Colors.white,) ,

         DrawerItem(icon:Image.asset(Images.contact,width: 20,height: 20,color: AppColors.appBarIcon,), text: "contact_us", onTap: (){}),

         DrawerItem(icon:const Icon(Icons.language , color: AppColors.appBarIcon), text: "language", onTap: (){
           Navigator.push( context,
               MaterialPageRoute(builder: (context) =>  Language())) ;
         }),
        // const  Divider(color: Colors.white,) ,
         DrawerItem(icon:const Icon(Icons.logout , color: AppColors.appBarIcon), text: "logout", onTap: () async {
             // delete user data shared
           shared = await SharedPreferences.getInstance();

           shared.clear() ;
             Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => Login()),
             );
         }),
       ],
     ),
         ));
  }
addDistance(){
  TextEditingController km  =  TextEditingController()  ;
  String err ="" ;
  showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return DistanceDialog(edTxtController: km , err: err, onCancelClick: (){
          Navigator.of(context).pop() ;
        } ,


          onOKClick:(){

            if(km.text.isEmpty) {
              setState(() {
                err  = getTranslated("write_reason", context)??"" ;
              });
            }
            else{
              Map m  = {"user_id":user.userId,"kilo_num":km.text} ;
              api.request(url: Constants.ADD_DISTANCE, map: m,
                  onSuccess:onAddedSuccess ,
                  onError: onError) ;
            }
          } ,);
      });
}
  onAddedSuccess (var jsonObj){
    var jsonStr = json.decode(jsonObj);
    String  msg  = jsonStr['msg']  ;
    print(msg) ;
    if(msg=="تمت عملية الاضافة بنجاح") {
      Navigator.of(context).pop();
     /* CustomDialog.dialog(context: context,
          title: "",
          message: msg,
          onOkClick:(){
          } ,
          isCancelBtn: false);*/
      setState(() {
        textAttBtn = "attendance";
        shared.setString("attend", "attendance") ;

      });

    }
    else{
      CustomDialog.dialog(context: context,
          title: "",
          message: msg,
          isCancelBtn: false);

    }
    print(jsonObj) ;
  }
}