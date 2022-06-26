import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/model/salary.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/view/base/bottom_nav_bar.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';
import 'package:marsa_delivery/view/base/no_thing_to_show.dart';
import 'package:marsa_delivery/view/screens/main_screen/widgets/salary_details.dart';
import 'package:marsa_delivery/view/screens/main_screen/widgets/salary_item.dart';
import 'package:marsa_delivery/view/screens/requests/add_holiday_request.dart';
import 'package:marsa_delivery/view/screens/requests/AddFinancialReq.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SalaryBody extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return _State();
  }

}

class _State extends State<SalaryBody> {

  bool loading= true;
  List<Salary>salaryList =[];
  User? user ;
  Salary?  s;
  Api api = Api() ;
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
    await     api.request(url:Constants.SALARYY, map: m, onSuccess: onSuccess, onError: onError)
    ;



  }
  onSuccess(var jsonStr){
    List<dynamic> list = json.decode(jsonStr);
    print (jsonStr);
   for (int i = 0 ; i < list.length ; i ++){
   var   jsonObj=list [i];
     s = Salary.fromJson(jsonObj);
   setState(() {
     salaryList.add(s!);

   });
   }
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
    return   Scaffold(
      bottomNavigationBar: AppBottomNavBar(3),

      appBar: AppBar(
        iconTheme:  const IconThemeData(color: AppColors.appBarIcon),
    systemOverlayStyle:const SystemUiOverlayStyle(
    // Status bar color
    statusBarColor: AppColors.statusAppBar,),
        backgroundColor: AppColors.appBar,title:Text( getTranslated("salary", context)??"",style: const TextStyle(color: AppColors.logRed),) ),

    body:  loading? const Center (child:CircularProgressIndicator(color: AppColors.logRed,)) :
    Container( height :double.infinity,child:
    Column(children: [
         salaryList.isNotEmpty?

         Expanded(child:ListView.builder(
      itemBuilder: (context  , index ){
        return SalaryItem(userSalary: salaryList[index],index:index ,onTap: (){
          Navigator.push( context,
              MaterialPageRoute(builder: (context) => SalaryDetails(s!))) ;
        },);
      } ,itemCount:  salaryList.length , ))
    :Expanded(child:NoThingToShow()),

    ])));
  }

}
