
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/model/financial.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/utill/app_images.dart';
import 'package:marsa_delivery/view/base/alert_dialog.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';
import 'package:marsa_delivery/view/screens/requests/widgets/EditText.dart';
import 'package:marsa_delivery/view/screens/requests/widgets/EditTextWithNum.dart';
import 'package:shared_preferences/shared_preferences.dart';
class FinancialReq extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return _State();
  }

}
class _State extends State<FinancialReq> {
  bool isLoading = false  ;
  TextEditingController reasonEd  =  TextEditingController()  ;
  TextEditingController moneyEd  =  TextEditingController()  ;
  TextEditingController dateEd  =  TextEditingController()  ;
  Api api  = Api() ;
  User? user  ;
  late SharedPreferences sharedPrefs ;
  DateTime selectedDate = DateTime.now();

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
            backgroundColor: AppColors.appBar,title:Text( getTranslated("financial_advance", context)??"",style: const TextStyle(color: AppColors.logRed),) ),

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

              Padding(padding: const EdgeInsets.only(left: 25 , right: 25 ,top: 30),child:Align(
                  alignment: Alignment.centerLeft, child: Text(getTranslated("request", context)??"" ,style: TextStyle(color: AppColors.logRed,fontSize: 20),))) ,
              Padding(padding: EdgeInsets.only(left: 28,right: 28,top: 30),child: Text(getTranslated("req_reason", context)??"",style: TextStyle(fontWeight: FontWeight.bold),),),
              EditText(edTxtController: reasonEd,imageStr: Images.date,color: AppColors.lightGrey, ),
              Padding(padding: EdgeInsets.only(left: 28,right: 28 ,top: 30),child: Text(getTranslated("money_req", context)??"",style: TextStyle(fontWeight: FontWeight.bold),)),

              EditTextWithNum(edTxtController: moneyEd,imageStr: Images.date, color:  AppColors.lightGrey,),
              Padding(padding: EdgeInsets.only(left: 28,right: 28,top: 30),child: Text(getTranslated("date", context)??"",style: TextStyle(fontWeight: FontWeight.bold)),),

              EditText(edTxtController: dateEd ,imageStr: Images.date,color:  AppColors.logRed,onTap:(){
                _selectDate() ;
              } ,),

    Padding(padding: const EdgeInsets.only(top: 100),child:  CustomBtn(buttonNm: getTranslated("add", context)??"", onClick: onAddBtn ,  backBtn:AppColors.logRed, txtColor: AppColors.white,)),

            ],)),
        ),
    );
  }
  onAddBtn(){
    api.checkInternet(onConnect: () {
      setState(() {
        String money  = moneyEd.text ;
        String reason  = reasonEd.text ;
        String date  = dateEd.text ;
        setState(() {
          bool isValidate =  validation(money: money, reason: reason, date: date) ;
          if(isValidate){
            isLoading = true  ;
            Financial request = Financial(date: date , money:money  , reason: reason )  ;

                Map m =request.toMap(user!.userId!);
            api.request(url: Constants.ADDFINANCIAL, map:m  , onError:  (String errorMsg
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
      CustomDialog.dialog(context: context, title: "", message: msg, isCancelBtn: false ,onOkClick: (){
        Navigator.of(context).pop() ;
      }) ;


  }
  bool validation ({required String money  ,required reason  , required String date} ){
    if(money.isEmpty) {
      return false  ;
    }
    else if(reason.isEmpty){
      return false  ;
    }  else if(date.isEmpty){
      return false  ;
    }
    else{
      return true ;
    }

  }
  _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        var formatter =  DateFormat("yyyy-MM-dd");
        String formattedDate = formatter.format(selectedDate);
        dateEd.text =formattedDate ;
      });
    }
  }

}