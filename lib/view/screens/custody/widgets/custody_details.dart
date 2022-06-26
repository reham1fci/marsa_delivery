
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
import 'package:marsa_delivery/view/screens/custody/widgets/custody_detais_item.dart';
import 'package:marsa_delivery/view/screens/custody/widgets/custody_item.dart';
import 'package:marsa_delivery/view/screens/main_screen/widgets/wallet_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CustodyDetails extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _State();
  }

}
class _State extends State<CustodyDetails> {
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
    Map m2 = {"driver_id":user!.userId} ;
    await  api.request(url:Constants.CUSTODYDETAILS, map: m2, onSuccess: onSuccess, onError: onError)
    ;
    print(Constants.CUSTODYDETAILS) ;
  }

  onSuccess(var jsonStr){
    print(jsonStr) ;
    List<dynamic> list = json.decode(jsonStr);
    print(jsonStr);
    for (int i = 0 ; i < list.length ; i ++){
      var   jsonObj=list [i];
      Custody  c = Custody.fromJsonDetails(jsonObj);
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
        appBar: AppBar(
            centerTitle: true,
            iconTheme:  const IconThemeData(color: AppColors.appBarIcon),
            systemOverlayStyle:const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: AppColors.statusAppBar,),
            backgroundColor: AppColors.appBar,title:Text( getTranslated("details", context)??"",style: const TextStyle(color: AppColors.logRed),) ),
        body:  loading? Center (child:CircularProgressIndicator(color: AppColors.logRed,)) :

        Container( height :double.infinity,child:
        Column(children: [
          custodyList.isNotEmpty?  Expanded(child: ListView.builder(
            itemBuilder: (context  , index ){
              return CustodyDetailsItem(custody: custodyList[index],index:index
              ,);
            } ,itemCount:  custodyList.length , ))
              : Expanded(child:NoThingToShow()),],)));

  }

}