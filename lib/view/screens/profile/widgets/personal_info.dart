
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/utill/app_images.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PersonalInfo extends StatefulWidget{
  User user ;

  PersonalInfo(this.user);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _State();
  }

}
class _State extends State<PersonalInfo> {
  Api  api = Api ();
  bool loading =true ;
String userName ="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              statusBarColor: AppColors.statusAppBar,),
            backgroundColor: AppColors.appBar,title:Text( getTranslated("personal_info", context)??"",style: const TextStyle(color: AppColors.logRed),) ),
        body:Padding(padding: EdgeInsets.all(30),child: Column(
          mainAxisAlignment: MainAxisAlignment.start ,// Center Row contents horizontally,
          crossAxisAlignment: CrossAxisAlignment.start ,
          children: [
            Padding(padding: EdgeInsets.only(top: 40),child: Center(child: CircleAvatar(
              //   radius: 56,
              child: ClipOval(child: Image.asset(Images.logo  ,)),
            ) )),

            Center(child:  Text(widget.user.name! ,style: TextStyle(color: Colors.black,fontSize: 17),)) ,
            Center(child:  Text(widget.user.userName!,style: TextStyle(color: Colors.black54))) ,
            Padding(padding: EdgeInsets.only(top: 40),child:   Text(getTranslated("name", context)??"" ,style: TextStyle(color: Colors.black,fontSize: 17),)),
            Text(widget.user.name!,style: TextStyle(color: Colors.black54)),
            Padding(padding: EdgeInsets.only(top: 30),child:   Text(getTranslated("email", context)??"" ,style: TextStyle(color: Colors.black,fontSize: 17),)),
            Text(widget.user.userName!,style: TextStyle(color: Colors.black54)),
            Padding(padding: EdgeInsets.only(top: 30),child:   Text(getTranslated("id_num", context)??"" ,style: TextStyle(color: Colors.black,fontSize: 17),)),
            Text(widget.user.idNum!,style: TextStyle(color: Colors.black54)),
            Padding(padding: EdgeInsets.only(top: 30),child:   Text(getTranslated("employee_id", context)??"" ,style: TextStyle(color: Colors.black,fontSize: 17),)),
            Text(widget.user.userId!,style: TextStyle(color: Colors.black54)),
          ],
        ),

        ) ) ;
  }

}