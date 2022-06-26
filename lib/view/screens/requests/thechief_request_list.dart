
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/model/bank.dart';
import 'package:marsa_delivery/model/custody.dart';
import 'package:marsa_delivery/model/custody_type.dart';
import 'package:marsa_delivery/model/thechief_request.dart';
import 'package:marsa_delivery/model/wallet.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/view/base/alert_dialog.dart';
import 'package:marsa_delivery/view/base/no_thing_to_show.dart';
import 'package:marsa_delivery/view/screens/custody/custody_delivery.dart';
import 'package:marsa_delivery/view/screens/custody/widgets/custody_item.dart';
import 'package:marsa_delivery/view/screens/main_screen/widgets/wallet_item.dart';
import 'package:marsa_delivery/view/screens/requests/widgets/payment_way_window.dart';
import 'package:marsa_delivery/view/screens/requests/widgets/thechief_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_thechief_request.dart';
class TheChiefReqList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _State();
  }

}
class _State extends State<TheChiefReqList> {
  bool loading= true;
  List<TheChiefRequest>list =[];
  List<Bank>paymentList  = [] ;

  User? user ;
  Api api = Api() ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentList.add(Bank(bankId: "1"  ,bankNm: "كاش" )) ;
    paymentList.add(Bank(bankId: "2"  ,bankNm: "online" )) ;
    getUserData();
  }
  getUserData() async {
    SharedPreferences  shared = await SharedPreferences.getInstance();
    user = User.fromJsonShared(json.decode(shared.getString("user")!));
    getRequestsList() ;

  }
  getRequestsList() async {
    list =[];
    Map m  = {"driver_id":user!.userId} ;
    print(m) ;
    await     api.request(url:Constants.SHOWTHESHEFSLIST, map: m, onSuccess: onSuccess, onError: onError) ;

  }

  onSuccess(var jsonStr){
    List<dynamic> jsonArr = json.decode(jsonStr);
    print(jsonStr);
    for (int i = 0 ; i < jsonArr.length ; i ++){
      var   jsonObj=jsonArr [i];
      TheChiefRequest  req = TheChiefRequest.fromJson(jsonObj);
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push( context,
                MaterialPageRoute(builder: (context) => AddTheChiefReq())).then((value){
                  getRequestsList() ;

            }) ;
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
            backgroundColor: AppColors.appBar,title:Text( getTranslated("requests", context)??"",style: const TextStyle(color: AppColors.logRed),) ),
        body:  loading? Center (child:CircularProgressIndicator(color: AppColors.logRed,)) :

        Container( height :double.infinity,child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            list.isNotEmpty?  Expanded(child: ListView.builder(
              itemBuilder: (context  , index ){
                return TheChiefItem(req:list[index],index:index ,onReceiveClick: (){
                 showPaymentPopup(index);
                } ,);
              } ,itemCount:  list.length , ))
                : Expanded(child:NoThingToShow()),],)));

  }
  showPaymentPopup(int index){
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return PaymentWindow(onOKClick: ( String b){
            setState(() {
              print(b) ;
receiveRequest(index, b);

            });

          },paymentList: paymentList,);
        });
  }
  receiveRequest(int index , String paymentType){
    Navigator.of(context).pop() ;
    TheChiefRequest c = list[index] ;
    Map m  = {"id" :c.id , "payment_type":paymentType};
    api.request(url: Constants.RECCHEFREQ, map: m, onSuccess: onSuccessReceive, onError: onError) ;
  }
  onSuccessReceive(var jsonObj){
    var jsonStr = json.decode(jsonObj);
    print(jsonStr);
    String  msg  = jsonStr['msg']  ;
    print(msg) ;
    setState(() {
      loading =true ;
    });
    if(msg=="تم تسليم الطلب بنجاح"){
      CustomDialog.dialog(context: context, title: "", message: msg, isCancelBtn: false ,onOkClick: (){

        getRequestsList() ;
      }) ;

    }
    else{
      CustomDialog.dialog(context: context, title: getTranslated("error" , context)??"error", message: msg, isCancelBtn: false) ;

    }

  }
}