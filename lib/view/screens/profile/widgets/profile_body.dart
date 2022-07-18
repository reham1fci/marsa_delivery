
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/utill/app_images.dart';
import 'package:marsa_delivery/view/base/bottom_nav_bar.dart';
import 'package:marsa_delivery/view/screens/profile/widgets/job_info.dart';
import 'package:marsa_delivery/view/screens/profile/widgets/personal_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_info.dart';
class ProfileBody extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return _State();
  }

}
class _State extends State<ProfileBody> {
  User? user  ;

  String? userName  ;
  String? userEmail  ;
  Api  api = Api ();
  bool loading =true ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }
  getUserData() async {
    SharedPreferences  shared = await SharedPreferences.getInstance();
    user = User.fromJsonShared(json.decode(shared.getString("user")!));
    setState(() {
      userName = user!.name  ;
      userEmail = user!.userName  ;
    });
    Map m  = {"user_id":user!.userId} ;
    await     api.request(url:Constants.PROFILE_URL, map: m, onSuccess: onSuccess, onError: onError)
    ;



  }
  onSuccess(var jsonStr){
    List<dynamic> list = json.decode(jsonStr);

    var jsonObj = list[0];
    user = User.fromJsonProfile(jsonObj);
    user?.userName =userEmail ;
    print(jsonObj) ;
    setState(() {
      loading= false ;
    });


  }

  onError(String err){
    print(err) ;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        bottomNavigationBar: AppBottomNavBar(4),

        appBar: AppBar(

        centerTitle: true,
          iconTheme:  const IconThemeData(color: AppColors.appBarIcon),
          systemOverlayStyle:const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: AppColors.statusAppBar,),
          backgroundColor: AppColors.appBar,title:Text( getTranslated("profile", context)??"",style: const TextStyle(color: AppColors.logRed),) ),
body:Padding(padding: EdgeInsets.all(30),child: Column(
  mainAxisAlignment: MainAxisAlignment.start ,// Center Row contents horizontally,
  crossAxisAlignment: CrossAxisAlignment.start ,
  children: [
Padding(padding: EdgeInsets.only(top: 40),child: Center(child: CircleAvatar(
      //   radius: 56,
      child: ClipOval(child: Image.asset(Images.logo  ,)),
    ) )),

    Center(child:  Text(userName! ,style: TextStyle(color: Colors.black,fontSize: 18),)) ,
    Center(child:  Text(userEmail!,style: TextStyle(color: Colors.black54))) ,
  Padding(padding: EdgeInsets.only(top: 40),child:  TextButton.icon(onPressed: goToPersonalInfo, icon: Icon(  Icons.person ,color: AppColors.logRed,), label: Text(getTranslated("personal_info", context)??"",style: TextStyle(color: Colors.black),)) ),
    Padding(padding: EdgeInsets.only(top: 20),child:     TextButton.icon(onPressed: goToJobInfo, icon: Icon(  Icons.work ,color: AppColors.logRed,), label: Text(getTranslated("job_info", context)??"",style: TextStyle(color: Colors.black))) ),
    Padding(padding: EdgeInsets.only(top: 20),child:    TextButton.icon(onPressed: goToAddInfo, icon: Icon(  Icons.add_box ,color: AppColors.logRed,), label: Text(getTranslated("add_info", context)??"",style: TextStyle(color: Colors.black),))) ,
  ],
),

) ) ;
  }
goToPersonalInfo(){
  Navigator.push( context,
      MaterialPageRoute(builder: (context) =>  PersonalInfo(user!))) ;
}goToJobInfo(){
  Navigator.push( context,
      MaterialPageRoute(builder: (context) =>  JobInfo(user!))) ;
}goToAddInfo(){
  Navigator.push( context,
      MaterialPageRoute(builder: (context) =>  AddInfo(user!))) ;
}
}