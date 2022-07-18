
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/model/thechief_request.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/utill/app_images.dart';
import 'package:marsa_delivery/view/base/alert_dialog.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';
import 'package:marsa_delivery/view/screens/requests/widgets/EditText.dart';
import 'package:marsa_delivery/view/screens/requests/widgets/EditTextWithNum.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AddTheChiefReq extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _State();
  }

}
class _State extends State<AddTheChiefReq> {
  bool isLoading = false  ;
  TextEditingController orderEd  =  TextEditingController()  ;
  TextEditingController totalEd  =  TextEditingController()  ;
  TextEditingController orderCostEd  =  TextEditingController()  ;
  TextEditingController deliverCostEd  =  TextEditingController()  ;
  Api api  = Api() ;
  late SharedPreferences sharedPrefs ;
  DateTime selectedDate = DateTime.now();
  User? user ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData() ;
  }
  getUserData() async {
    SharedPreferences  shared = await SharedPreferences.getInstance();
    user = User.fromJsonShared(json.decode(shared.getString("user")!));

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      backgroundColor: AppColors.white,
      appBar: AppBar(
          centerTitle: true,
          iconTheme:  const IconThemeData(color: AppColors.appBarIcon),
          systemOverlayStyle:const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: AppColors.statusAppBar,),
          backgroundColor: AppColors.appBar,title:Text( getTranslated("the_chief_request", context)??"",style: const TextStyle(color: AppColors.logRed),) ),

      body:
      Center(

        child: SingleChildScrollView(child:   Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            isLoading? const Center(
              child: CircularProgressIndicator(color: AppColors.logRed,),
            ): const SizedBox(),
            //  Spacer() ,

          Padding(padding: EdgeInsets.only(left: 28,right: 28,top: 30),child: Text(getTranslated("order_num", context)??"",style: TextStyle(fontWeight: FontWeight.bold),),),
            EditTextWithNum(edTxtController: orderEd,imageStr: Images.date,color: AppColors.lightGrey, ),
            Padding(padding: EdgeInsets.only(left: 28,right: 28 ,top: 30),child: Text(getTranslated("total_cost", context)??"",style: TextStyle(fontWeight: FontWeight.bold),)),

            EditTextWithNum(edTxtController: totalEd,imageStr: Images.date, color:  AppColors.lightGrey,),
            Padding(padding: EdgeInsets.only(left: 28,right: 28,top: 30),child: Text(getTranslated("order_cost", context)??"",style: TextStyle(fontWeight: FontWeight.bold)),),

            EditTextWithNum(edTxtController: orderCostEd,imageStr: Images.date, color:  AppColors.lightGrey,),

            Padding(padding: EdgeInsets.only(left: 28,right: 28 ,top: 30),child: Text(getTranslated("deliver_cost", context)??"",style: TextStyle(fontWeight: FontWeight.bold),)),

            EditTextWithNum(edTxtController: deliverCostEd,imageStr: Images.date, color:  AppColors.lightGrey,),

            Padding(padding: const EdgeInsets.only(top: 100),child:  CustomBtn(buttonNm: getTranslated("add", context)??"", onClick: onAddBtn ,  backBtn:AppColors.logRed, txtColor: AppColors.white,)),

          ],)),

      ),
    );
  }
  onAddBtn(){
    api.checkInternet(onConnect: () {
      setState(() {
        String total  = totalEd.text ;
        String orderCost  = orderCostEd.text ;
        String deliveryCost  = deliverCostEd.text ;
        String orderNum  = orderEd.text ;
        setState(() {
          bool isValidate =   validation(deliverCost: deliveryCost , orderCost: orderCost , total: total,orderNum: orderNum)  ;
          if(isValidate){
            isLoading = true  ;
            TheChiefRequest request = TheChiefRequest(orderNum: orderNum, orderCost:orderCost  ,deliverCost: deliveryCost , totalCost: total) ;
            Map m =request.toMap(user!.userId!);
            api.request(url: Constants.AddTHECHIEFREQ, map:m  , onError:  (String errorMsg
                ){
              CustomDialog.dialog(context: context, title: "", message: errorMsg, isCancelBtn: false) ;
            }

                , onSuccess:onAddSuccess
            );

          }
          else{
            CustomDialog.dialog(context: context, title: "", message: getTranslated("fill_data", context)??"", isCancelBtn: false) ;

          }
        });

      });
    },notConnect: (){
      CustomDialog.dialog(context: context  , title:getTranslated("error" , context)??"error"
          , isCancelBtn: false ,message:getTranslated("no_internet" , context)??"No Internet Connection"  , onOkClick: (){} ) ;

    });

  }
onAddSuccess(var jsonObj ){
  var jsonStr = json.decode(jsonObj);
  print(jsonStr);
  String  msg  = jsonStr['msg']  ;
  print(msg) ;
  setState(() {
  isLoading =false ;
  });
  if(msg=="تمت عملية اضافة الطلب بنجاح"){
  CustomDialog.dialog(context: context, title: "", message: msg, isCancelBtn: false ,onOkClick: (){
Navigator.of(context).pop() ;
  }) ;

  }
  else{
  CustomDialog.dialog(context: context, title: getTranslated("error" , context)??"error", message: msg, isCancelBtn: false) ;

  }
}
  bool validation ({required String orderNum  ,required String total , required String deliverCost , required String orderCost} ){
    if(orderNum.isEmpty) {
      return false  ;
    }
    else if(total.isEmpty){
      return false  ;
    }  else if(orderCost.isEmpty){
      return false  ;
    }
    else if(deliverCost.isEmpty){
      return false  ;
    }
    else{
      return true ;
    }

  }
}