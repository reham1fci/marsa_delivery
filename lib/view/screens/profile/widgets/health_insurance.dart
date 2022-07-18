
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/model/financial.dart';
import 'package:marsa_delivery/model/hosiptal.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';
import 'package:marsa_delivery/view/base/no_thing_to_show.dart';
import 'package:marsa_delivery/view/screens/profile/widgets/hospital_item.dart';
import 'package:marsa_delivery/view/screens/requests/AddFinancialReq.dart';
import 'package:marsa_delivery/view/screens/requests/widgets/financial_item.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HealthInsurance extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _State();
  }

}
class _State extends State<HealthInsurance> {
  bool loading= true;
  List<Hospital>list =[];

  User? user ;
  Api api = Api() ;
  bool enableBtn = false  ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserData();
  }
  getUserData() async {
    SharedPreferences  shared = await SharedPreferences.getInstance();
    user = User.fromJsonShared(json.decode(shared.getString("user")!));
    getRequestsList() ;

  }
  getRequestsList() async {
    list =[];
    Map m  = {"employ_id":user!.userId} ;
    print(m) ;
    await     api.request(url:Constants.SHOWFINANCIAL, map: m, onSuccess: onSuccess, onError: onError) ;

  }

  onSuccess(var jsonStr){
    List<dynamic> jsonArr = json.decode(jsonStr);
    print(jsonStr);
    for (int i = 0 ; i < jsonArr.length ; i ++){
      var   jsonObj=jsonArr [i];
      Hospital req = Hospital.fromJson(jsonObj);
      setState(() {
        list.add(req);

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
        appBar: AppBar(
            centerTitle: true,
            iconTheme:  const IconThemeData(color: AppColors.appBarIcon),
            systemOverlayStyle:const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: AppColors.statusAppBar,),
            backgroundColor: AppColors.appBar,title:Text( getTranslated("hospital_insurance", context)??"",style: const TextStyle(color: AppColors.logRed),) ),
        body:  loading? Center (child:CircularProgressIndicator(color: AppColors.logRed,)) :

        Container( height :double.infinity,child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            list.isNotEmpty?  Expanded(child: ListView.builder(
              itemBuilder: (context  , index ){
                return HospitalItem(req:list[index],index:index

                  ,);
              } ,itemCount:  list.length , ))
                : Expanded(child:NoThingToShow()),

          ],)));

  }


}