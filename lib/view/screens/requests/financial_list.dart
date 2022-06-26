
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/model/bank.dart';
import 'package:marsa_delivery/model/custody.dart';
import 'package:marsa_delivery/model/custody_type.dart';
import 'package:marsa_delivery/model/financial.dart';
import 'package:marsa_delivery/model/holiday.dart';
import 'package:marsa_delivery/model/thechief_request.dart';
import 'package:marsa_delivery/model/wallet.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/view/base/alert_dialog.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';
import 'package:marsa_delivery/view/base/custom_button_witout_padding.dart';
import 'package:marsa_delivery/view/base/no_thing_to_show.dart';
import 'package:marsa_delivery/view/screens/custody/custody_delivery.dart';
import 'package:marsa_delivery/view/screens/custody/widgets/custody_item.dart';
import 'package:marsa_delivery/view/screens/main_screen/widgets/wallet_item.dart';
import 'package:marsa_delivery/view/screens/requests/AddFinancialReq.dart';
import 'package:marsa_delivery/view/screens/requests/add_holiday_request.dart';
import 'package:marsa_delivery/view/screens/requests/widgets/financial_item.dart';
import 'package:marsa_delivery/view/screens/requests/widgets/holiday_item.dart';
import 'package:marsa_delivery/view/screens/requests/widgets/payment_way_window.dart';
import 'package:marsa_delivery/view/screens/requests/widgets/thechief_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_thechief_request.dart';
class FinancialList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _State();
  }

}
class _State extends State<FinancialList> {
  bool loading= true;
  List<Financial>list =[];

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
      Financial req = Financial.fromJson(jsonObj);
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
            backgroundColor: AppColors.appBar,title:Text( getTranslated("loan_request", context)??"",style: const TextStyle(color: AppColors.logRed),) ),
        body:  loading? Center (child:CircularProgressIndicator(color: AppColors.logRed,)) :

        Container( height :double.infinity,child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            list.isNotEmpty?  Expanded(child: ListView.builder(
              itemBuilder: (context  , index ){
                return FinancialItem(req:list[index],index:index

                  ,);
              } ,itemCount:  list.length , ))
                : Expanded(child:NoThingToShow()),

            Padding(padding: EdgeInsets.only(bottom: 40 ,top: 40 ,right: 10 ,left: 10) , child:
         CustomBtn(buttonNm:
            getTranslated("add_request", context)??"", onClick: (){
              Navigator.push( context,
                  MaterialPageRoute(builder: (context) => FinancialReq())).then((value){
                    getRequestsList() ;
              }) ;
            } ,  backBtn:AppColors.logRed, txtColor: AppColors.white,),
            )
          ],)));

  }


}