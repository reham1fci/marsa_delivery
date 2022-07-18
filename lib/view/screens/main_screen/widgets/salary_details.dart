import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/model/salary.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SalaryDetails extends StatefulWidget{
Salary _salary;

  SalaryDetails(this._salary);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return _State();
  }

}
class _State extends State<SalaryDetails> {

  bool loading =true ;
  Api  api = Api ();
  User? user;
  Salary? salary;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    salary = widget._salary;
    getUserData();
  }


  getUserData() async {
    SharedPreferences  shared = await SharedPreferences.getInstance();
    user = User.fromJsonShared(json.decode(shared.getString("user")!));
    Map m  = {"user_id":user!.userId,"month":salary!.month!, "year":salary!.year
    } ;
    await     api.request(url:Constants.SALARYDETAILS, map: m, onSuccess: onSuccess, onError: onError)
    ;



  }

  onSuccess(var jsonStr){
    List<dynamic> list = json.decode(jsonStr);

    var jsonObj = list[0];
    print (jsonStr);
    salary = Salary.fromJsonDetails(jsonObj);
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
          tableRow(getTranslated("name", context)??"", salary!.name!),
          tableRow(getTranslated("id_num", context)??"", salary!.idNum!),
          tableRow(getTranslated("housing_allowance", context)??"", salary!.housingAllowance!),
          tableRow(getTranslated("trans_allowance", context)??"", salary!.transAllowance!),
          tableRow(getTranslated("employment_date", context)??"",  salary!.employeeDate!),
          tableRow(getTranslated("salary", context)??"",  salary!.sumSalary!.toString()),
          tableRow(getTranslated("deduction", context)??"",  salary!.deduction!),
          tableRow(getTranslated("net_salary", context)??"",  salary!.netSalary!),
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