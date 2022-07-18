
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
import 'package:marsa_delivery/view/base/alert_dialog.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';
import 'package:marsa_delivery/view/screens/Attendance/active_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LeaveView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return _State();
  }

}
class _State extends State<LeaveView> {
  TextEditingController distanceEd  =  TextEditingController()  ;
String? errorTxt = null ;
  Api api = Api() ;
  Location location = new Location();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar: AppBar(
       centerTitle: true,
         iconTheme:  const IconThemeData(color: AppColors.appBarIcon),
         systemOverlayStyle:const SystemUiOverlayStyle(
           // Status bar color

           statusBarColor: AppColors.statusAppBar,),
         backgroundColor: AppColors.appBar,title:Text( getTranslated("leave", context)??"",style: const TextStyle(color: AppColors.logRed),) ),
body: Padding(padding:EdgeInsets.all(10)  , child:Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(padding: EdgeInsets.all(10) , child:  Text(getTranslated("active_title", context)??"", style: TextStyle(color: AppColors.logRed ,fontSize: 18),) ) ,
    Padding(padding: EdgeInsets.all(10) , child:   Text(getTranslated("track_location", context)??"") ),

   distanceView() ,
    Spacer() ,

    CustomBtn(buttonNm: getTranslated("confirm", context)??"", backBtn: AppColors.logRed, txtColor: AppColors.white, onClick:confirmBtn

    ),
],),
   )) ;
  }
  confirmBtn() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    User  user = User.fromJsonShared(json.decode(shared.getString("user")!));

    shared.setString("attend", "leave");
    setState(() {

    });
    String km  = distanceEd.text ;
    if(km.isEmpty) {
      setState(() {
        errorTxt  = getTranslated("add_daily_distance", context)??"" ;
      });
    }
    else{
      Map m  = {"user_id":user.userId,"kilo_num":km} ;
      api.request(url: Constants.ADD_DISTANCE, map: m,
          onSuccess:onAddedSuccess ,
          onError: onError) ;
    }
  }
  onError(String err){
    print(err) ;
  }
  onAddedSuccess (var jsonObj){
    var jsonStr = json.decode(jsonObj);
    String  msg  = jsonStr['msg']  ;
    ActiveState().stopTimer() ;
    print(msg) ;
    if(msg=="تمت عملية الاضافة بنجاح") {
       CustomDialog.dialog(context: context,
          title: "",
          message: msg,
          onOkClick:(){
            Navigator.of(context).pop();

          } ,
          isCancelBtn: false);
    }
    else{
      CustomDialog.dialog(context: context,
          title: "",
          message: msg,
          isCancelBtn: false);

    }
    print(jsonObj) ;
  }
Widget distanceView(){
 return Padding(padding: const EdgeInsets.only(bottom: 30.0 , left: 30.0  , right: 30.0 , top: 30.0) ,
    child:   TextField(controller:  distanceEd,keyboardType: TextInputType.number,
      decoration: InputDecoration(
        //  hintText: getTranslated("add_daily_distance", context)??"" ,
        hintStyle: TextStyle(color: AppColors.greyDark),
        fillColor: Colors.white,
        filled: false,
        errorText: errorTxt,
        labelText: getTranslated("add_daily_distance", context)??"",
        labelStyle: TextStyle(color: AppColors.logRed),
        prefixIcon: Container(
          padding:  const EdgeInsets.symmetric(vertical: 10),
          child:const Image(
            image: AssetImage(
              Images.car,
            ),
            height: 20,
            width: 20,
          ),
        )
      ) , style:  TextStyle(color: AppColors.black) ,
    ),) ;
}
}