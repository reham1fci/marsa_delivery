
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
    await     api.request(url:Constants.SHOWCUSTODY, map: m, onSuccess: onSuccess, onError: onError)
    ;
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

          iconTheme:  const IconThemeData(color: AppColors.appBarIcon),
          systemOverlayStyle:const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: AppColors.statusAppBar,),
          backgroundColor: AppColors.appBar,title:Text( getTranslated("custody", context)??"",style: const TextStyle(color: AppColors.logRed),) ),
      body:  loading? Center (child:CircularProgressIndicator(color: AppColors.logRed,)) :
      custodyList.isNotEmpty?
      ListView.builder(
        itemBuilder: (context  , index ){
          return CustodyItem(custody: custodyList[index],index:index ,onReceiveClick: (){
            receiveCustody(index) ;
          },);
        } ,itemCount:  custodyList.length , )
          :NoThingToShow(),);

  }
  receiveCustody(int index){
    Custody c = custodyList[index] ;
   Map m  = c.custodyToMap(user!.userId!) ;
    api.request(url: Constants.RECEIVECUSTODY, map: m, onSuccess: onSuccessReceive, onError: onError) ;
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

}