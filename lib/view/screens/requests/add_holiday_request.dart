
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/model/bank.dart';
import 'package:marsa_delivery/model/holiday.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/utill/app_images.dart';
import 'package:marsa_delivery/view/base/alert_dialog.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';
import 'package:marsa_delivery/view/base/dropdown_btn.dart';
import 'package:marsa_delivery/view/screens/requests/widgets/EditText.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AddHolidayReq extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _State();
  }

}
class _State extends State<AddHolidayReq> {
  bool isLoading = false  ;
  TextEditingController reasonEd  =  TextEditingController()  ;
  TextEditingController fromDateEd  =  TextEditingController()  ;
  TextEditingController toDateEd  =  TextEditingController()  ;
  Api api  = Api() ;
  late SharedPreferences sharedPrefs ;
  DateTime selectedDate = DateTime.now();
  late List<String>holidayType=[]  ;
  String type="0";
   User? user  ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    holidayType.add( "طارئه" ) ;
    holidayType.add( "اعتياديه" ) ;
    holidayType.add( "مرضيه") ;
    getUserData() ;
  }

  getUserData() async {
    SharedPreferences  shared = await SharedPreferences.getInstance();
    user = User.fromJsonShared(json.decode(shared.getString("user")!));

  }
  @override
  Widget build(BuildContext context) {
    final _screen =  MediaQuery.of(context).size;

    // TODO: implement build
    return Scaffold(

      backgroundColor: AppColors.white,
      appBar: AppBar(
          centerTitle: true,
          iconTheme:  const IconThemeData(color: AppColors.appBarIcon),
          systemOverlayStyle:const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: AppColors.statusAppBar,),
          backgroundColor: AppColors.appBar,title:Text( getTranslated("holiday_req", context)??"",style: const TextStyle(color: AppColors.logRed),) ),

      body:
     // Center(child:
       // SingleChildScrollView(child:
        Column(
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

          Padding(padding: EdgeInsets.only(bottom: 8.0 , left: 30.0  , right: 30.0 , top: 8.0)    ,
                child:DropDownBtn(items:holidayType  , onChanged:(value){
                  setState(() {
print(holidayType.indexOf(value));
type=holidayType.indexOf(value).toString() ;
                  });
                }) ),
    /* Padding(padding: EdgeInsets.only(left: 28,right: 28,top: 30) ,child:
     SizedBox(
   child: Row(

              children: [
                

                Text(getTranslated("from", context)??"",style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 200,) ,
                Text(getTranslated("to", context)??"",style: TextStyle(fontWeight: FontWeight.bold)),
            ],) )),*/
    Row(
    children: [
    Container(
    width: _screen.width * 0.50,
   child: Column(children:[
    Padding(padding: EdgeInsets.only(top: 30),child: Text(getTranslated("from", context)??"",style: TextStyle(fontWeight: FontWeight.bold))),

     EditText(edTxtController: fromDateEd ,imageStr: Images.date,color:  AppColors.logRed,onTap:(){
    _selectDate(fromDateEd) ;
    } ,),])),
      //SizedBox(width: 50,) ,

      Container(
        width: _screen.width * 0.50,
        child: Column(children:[
    Padding(padding: EdgeInsets.only(top: 30),child:   Text(getTranslated("to", context)??"",style: TextStyle(fontWeight: FontWeight.bold),)),

          EditText(edTxtController: toDateEd ,imageStr: Images.date,color:  AppColors.logRed,onTap:(){
    _selectDate(toDateEd) ;
    } ,)]),

      )],),
            Padding(padding: const EdgeInsets.only(top: 100),child:  CustomBtn(buttonNm: getTranslated("add", context)??"", onClick: onAddBtn ,  backBtn:AppColors.logRed, txtColor: AppColors.white,)),

     ],)

     // ),
      //),
    );
  }
  onAddBtn(){
    api.checkInternet(onConnect: () {
      setState(() {
        String reason  = reasonEd.text ;
        String from  = fromDateEd.text ;
        String to  = toDateEd.text ;
        setState(() {
          bool isValidate =   validation(reason: reason, from: from, to: to, type: type)  ;
          if(isValidate){
            isLoading = true  ;
            Holiday h  = Holiday(type:type  , from: from , reason:reason, to: to ) ;
            Map m =h.toMap(user!.userId!);
            api.request(url: Constants.ADDHOLIDAY, map:m  , onError:  (String errorMsg
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
      Navigator.of(context).pop() ;});
  }
  bool validation ({required String reason  ,required String from , required String to ,
    required String type} ){
    if(reason.isEmpty) {
      return false  ;
    }
    else if(from.isEmpty){
      return false  ;
    }  else if(to.isEmpty){
      return false  ;
    }
    else if(type.isEmpty){
      return false  ;
    }
    else{
      return true ;
    }

  }
    _selectDate(TextEditingController ed) async {
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
        ed.text =formattedDate ;
      });
    }
  }

}