import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileBody extends StatefulWidget{
  const ProfileBody({Key? key}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  bool loading =true ;
  Api  api = Api ();
  User? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  getUserData() async {
    SharedPreferences  shared = await SharedPreferences.getInstance();
     user = User.fromJsonShared(json.decode(shared.getString("user")!));
    Map m  = {"user_id":user!.userId} ;
    await     api.request(url:Constants.PROFILE_URL, map: m, onSuccess: onSuccess, onError: onError)
    ;



  }
  onSuccess(var jsonStr){
    List<dynamic> list = json.decode(jsonStr);

    var jsonObj = list[0];
    user = User.fromJsonProfile(jsonObj);
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
    appBar: AppBar(
    backgroundColor: AppColors.colorPrimary  ,
    title: Text(getTranslated("profile", context)??"")),
    body:loading ?const Center(
      child: CircularProgressIndicator(color: AppColors.logRed,),
    ): Table(
    border:  const TableBorder(horizontalInside:  BorderSide(
    width: 1.0, color:AppColors.colorPrimary),
    verticalInside: BorderSide.none,
    left: BorderSide(width: 1.0, color: AppColors.colorPrimary),
    right: BorderSide(width: 1.0, color: AppColors.colorPrimary),
    bottom: BorderSide(width: 1.0, color:AppColors.colorPrimary),
    top: BorderSide(width: 1.0, color: AppColors.colorPrimary),
    ),children: [
      tableRow(getTranslated("name", context)??"", user!.name!),
      tableRow(getTranslated("id_num", context)??"", user!.idNum!),
      tableRow(getTranslated("vacation", context)??"", user!.vacation!),
      tableRow(getTranslated("salary", context)??"", user!.salary!),
      tableRow(getTranslated("housing_allowance", context)??"", user!.housingAllowance!),
      tableRow(getTranslated("trans_allowance", context)??"", user!.transAllowance!),
      tableRow(getTranslated("pass_end_date", context)??"", user!.passEndDate!),
      tableRow(getTranslated("insurance_card_end", context)??"",  user!.insuranceCardEndDate!),
      tableRow(getTranslated("insurance_end", context)??"",  user!.insuranceEndDate!),
      tableRow(getTranslated("licence_end_date", context)??"",  user!.licenceEndDate!),
      tableRow(getTranslated("employment_date", context)??"",  user!.employeeDate!),
      tableRow(getTranslated("work_end_date", context)??"",  user!.employeeEndDate!),
      tableRow(getTranslated("test_period", context)??"",  user!.testPeriod!),
      tableRow(getTranslated("employee_target", context)??"",  user!.employeeTarget!),
    ],));  }

TableRow tableRow( String  title ,String value ){
  return  TableRow(
      children: [

         Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,style: TextStyle(color: AppColors.logRed),),
        ),
         Padding(
            padding:  const EdgeInsets.all(8.0),
            child: Text(value)),
      ]);
}
}