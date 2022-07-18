
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/model/bank.dart';
import 'package:marsa_delivery/model/custody.dart';
import 'package:marsa_delivery/model/custody_type.dart';
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
import 'package:marsa_delivery/view/screens/requests/add_holiday_request.dart';
import 'package:marsa_delivery/view/screens/requests/widgets/holiday_item.dart';
import 'package:marsa_delivery/view/screens/requests/widgets/payment_way_window.dart';
import 'package:marsa_delivery/view/screens/requests/widgets/thechief_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_thechief_request.dart';
class HolidayList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _State();
  }

}
class _State extends State<HolidayList> {
  bool loading= true;
  List<Holiday>list =[];

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
    await     api.request(url:Constants.SHOWHOLIDAY, map: m, onSuccess: onSuccess, onError: onError) ;

  }

  onSuccess(var jsonStr){
    List<dynamic> jsonArr = json.decode(jsonStr);
    print(jsonStr);
    for (int i = 0 ; i < jsonArr.length ; i ++){
      var   jsonObj=jsonArr [i];
      Holiday req = Holiday.fromJson(jsonObj);
      if(req.statNum =="1"||req.statNum=="5"){
        enableBtn = true  ;
      }
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
            backgroundColor: AppColors.appBar,title:Text( getTranslated("requests", context)??"",style: const TextStyle(color: AppColors.logRed),) ),
        body:  loading? Center (child:CircularProgressIndicator(color: AppColors.logRed,)) :

        Container( height :double.infinity,child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            list.isNotEmpty?  Expanded(child: ListView.builder(
              itemBuilder: (context  , index ){
                return HolidayItem(req:list[index],index:index

                ,);
              } ,itemCount:  list.length , ))
                : Expanded(child:NoThingToShow()),

            Padding(padding: EdgeInsets.only(bottom: 40 ,top: 40 ,right: 10 ,left: 10) , child:
            enableBtn?    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  CustomBtnWoutPadd(buttonNm:
            getTranslated("holiday_req", context)??"", onClick: (){
              Navigator.push( context,
                  MaterialPageRoute(builder: (context) => AddHolidayReq())).then((value){
                getRequestsList() ;
              })  ;
            } ,  backBtn:AppColors.logRed, txtColor: AppColors.white,),
//Spacer() ,
   CustomBtnWoutPadd(buttonNm: getTranslated("continue_work_req", context)??"", onClick:onContinueWorkReq ,
    backBtn:AppColors.logRed, txtColor: AppColors.white,)
                ],):  CustomBtn(buttonNm:
            getTranslated("holiday_req", context)??"", onClick: (){
              Navigator.push( context,
                  MaterialPageRoute(builder: (context) => AddHolidayReq())) ;
            } ,  backBtn:AppColors.logRed, txtColor: AppColors.white,),
            )
          ],)));

  }
   onContinueWorkReq() async {
     Map m  = {"employ_id":user!.userId} ;
     setState(() {
       loading = true  ;
     });
     print(m) ;
     await     api.request(url:Constants.DIRECTWORk, map: m, onSuccess: onSuccessReq, onError: onError) ;

   }
  onSuccessReq(var jsonObj){
    var jsonStr = json.decode(jsonObj);
    print(jsonStr);
    String  msg  = jsonStr['msg']  ;
    print(msg) ;
    setState(() {
      loading =true ;
    });
      CustomDialog.dialog(context: context, title: "", message: msg, isCancelBtn: false ,onOkClick: (){

        getRequestsList() ;
      }) ;



  }


}