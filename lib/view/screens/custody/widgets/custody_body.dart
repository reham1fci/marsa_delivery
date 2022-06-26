
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/model/custody.dart';
import 'package:marsa_delivery/model/wallet.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/view/base/alert_dialog.dart';
import 'package:marsa_delivery/view/base/no_thing_to_show.dart';
import 'package:marsa_delivery/view/screens/custody/custody_delivery.dart';
import 'package:marsa_delivery/view/screens/custody/widgets/custody_item.dart';
import 'package:marsa_delivery/view/screens/main_screen/widgets/wallet_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'custody_details.dart';
class CustodyBody extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _State();
  }

}
class _State extends State<CustodyBody> {
  bool loading= true;
  List<Custody>custodyList =[];
  User? user ;
  Api api = Api() ;
  String credit="0.0"  ;
  String debit ="0.0"  ;
  String balance ="0.0" ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }
  getUserData() async {
    SharedPreferences  shared = await SharedPreferences.getInstance();
    user = User.fromJsonShared(json.decode(shared.getString("user")!));
    getCustodyList() ;

  }
  getCustodyList() async {
    custodyList =[];
    Map m  = {"user_id":user!.userId} ;
    await     api.request(url:Constants.SHOWCUSTODY, map: m, onSuccess: onSuccess, onError: onError) ;
    Map m2 = {"driver_id":user!.userId} ;

    await     api.request(url:Constants.SHOWTOTALCUSTODY, map: m2, onSuccess: onSuccessReq2, onError: onError)
    ;
  }
  onSuccessReq2(var jsonStr){
    print(jsonStr);
    var jsonObj = json.decode(jsonStr);
      Wallet wallet  = Wallet.fromJsonCustody(jsonObj) ;
      setState(() {
        credit =wallet.credit! ;
        debit= wallet.debit!  ;
        balance = wallet.balance!;

      });


  }
  onSuccess(var jsonStr){
    List<dynamic> list = json.decode(jsonStr);
    print(jsonStr);
  for (int i = 0 ; i < list.length ; i ++){
      var   jsonObj=list [i];
      Custody  c = Custody.fromJson(jsonObj);
      setState(() {
        custodyList.add(c);

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push( context,
              MaterialPageRoute(builder: (context) => CustodyDelivery())) ;
        },
        backgroundColor: AppColors.logRed,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
centerTitle: true,
          iconTheme:  const IconThemeData(color: AppColors.appBarIcon),
          systemOverlayStyle:const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: AppColors.statusAppBar,),
          backgroundColor: AppColors.appBar,title:Text( getTranslated("custody", context)??"",style: const TextStyle(color: AppColors.logRed),) ),
      body:  loading? Center (child:CircularProgressIndicator(color: AppColors.logRed,)) :

      Container( height :double.infinity,child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           Align(alignment: Alignment.topRight,child: TextButton(onPressed: (){
              Navigator.push( context,
                  MaterialPageRoute(builder: (context) => CustodyDetails())) ;
            }, child: Text(getTranslated("details", context)??"" ,style: TextStyle(color: Colors.black),)) ),
            totalTable(),
      custodyList.isNotEmpty?  Expanded(child: ListView.builder(
        itemBuilder: (context  , index ){
          return CustodyItem(custody: custodyList[index],index:index ,onReceiveClick: (){
            receiveCustody(index) ;
          },onRejectClick:(){
            rejectCustody(index) ;
          } ,);
        } ,itemCount:  custodyList.length , ))
          : Expanded(child:NoThingToShow()),],)));

  }
  receiveCustody(int index){
    Custody c = custodyList[index] ;
   Map m  = c.custodyToMap(user!.userId!) ;
    api.request(url: Constants.RECEIVECUSTODY, map: m, onSuccess: onSuccessReceive, onError: onError) ;
  } rejectCustody(int index){
    Custody c = custodyList[index] ;
   Map m  = {"id" :c.id} ;
    api.request(url: Constants.REJECTCUSTODY, map: m, onSuccess: onSuccessReject, onError: onError) ;
    print( Constants.REJECTCUSTODY) ;
  }
  onSuccessReject(var jsonObj){
    var jsonStr = json.decode(jsonObj);
    print(jsonStr);
    String  msg  = jsonStr['msg']  ;
    print(msg) ;
    setState(() {
      loading =true ;
    });
    if(msg=="تمت عمليةالرفض بنجاح"){
      CustomDialog.dialog(context: context, title: "", message: msg, isCancelBtn: false ,onOkClick: (){

        getCustodyList() ;
      }) ;

    }
    else{
      CustomDialog.dialog(context: context, title: getTranslated("error" , context)??"error", message: msg, isCancelBtn: false) ;

    }

  }
   onSuccessReceive(var jsonObj){
     var jsonStr = json.decode(jsonObj);
     print(jsonStr);
     String  msg  = jsonStr['msg']  ;
     print(msg) ;
     setState(() {
       loading =true ;
     });
     if(msg=="تمت عملية الاستلام بنجاح"){
       CustomDialog.dialog(context: context, title: "", message: msg, isCancelBtn: false ,onOkClick: (){

getCustodyList() ;
       }) ;

     }
     else{
       CustomDialog.dialog(context: context, title: getTranslated("error" , context)??"error", message: msg, isCancelBtn: false) ;

     }

   }
   Widget totalTable (){
    return
    Padding(padding: EdgeInsets.all(15.0) ,child:  Table(
        border:  const TableBorder(horizontalInside:  BorderSide(
            width: 1.0, color:AppColors.logRed),
          verticalInside:  BorderSide(
              width: 1.0, color:AppColors.logRed),
          left: BorderSide(width: 1.0, color: AppColors.logRed),
          right: BorderSide(width: 1.0, color: AppColors.logRed),
          bottom: BorderSide(width: 1.0, color:AppColors.logRed),
          top: BorderSide(width: 1.0, color: AppColors.logRed),

        ),children: [
        tableRow(getTranslated("debit", context)??"", getTranslated("credit", context)??"" ,getTranslated("balance", context)??"" ,AppColors.logRed),
        tableRow(debit, credit ,balance.toString() ,Colors.black)
      ],));  }


  TableRow tableRow( String  s ,String s2  ,String s3 , Color color ){
    return  TableRow(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(s,style: TextStyle(color:color,),          textAlign: TextAlign.center,
                ),
          ),
          Padding(
              padding:  const EdgeInsets.all(8.0),
    child: Text(s2,style: TextStyle(color: color) , textAlign: TextAlign.center,)),
          Padding(
              padding:  const EdgeInsets.all(8.0),
    child: Text(s3,style: TextStyle(color: color),  textAlign: TextAlign.center,),)
        ]
    );
  }

}