
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/model/wallet.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/view/base/bottom_nav_bar.dart';
import 'package:marsa_delivery/view/base/no_thing_to_show.dart';
import 'package:marsa_delivery/view/screens/main_screen/widgets/wallet_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
class WalletDetails extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return _State();
  }

}
class _State extends State<WalletDetails> {
  bool loading= true;
  List<Wallet>walletList =[];
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
    Map m  = {"user_id":user!.userId} ;
    await     api.request(url:Constants.WALlET, map: m, onSuccess: onSuccess, onError: onError)
    ;



  }
  onSuccess(var jsonStr){
    List<dynamic> list = json.decode(jsonStr);
print(jsonStr);
    for (int i = 0 ; i < list.length ; i ++){
      var   jsonObj=list [i];
      Wallet  w = Wallet.fromJson(jsonObj);
      setState(() {
        walletList.add(w);

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
      bottomNavigationBar: AppBottomNavBar(1),

      appBar: AppBar(
          iconTheme:  const IconThemeData(color: AppColors.appBarIcon),
          systemOverlayStyle:const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: AppColors.statusAppBar,),
          backgroundColor: AppColors.appBar,title:Text( getTranslated("wallet", context)??"",style: const TextStyle(color: AppColors.logRed),) ),
      body:  loading? Center (child:CircularProgressIndicator(color: AppColors.logRed,)) :
      walletList.isNotEmpty?
      ListView.builder(
        itemBuilder: (context  , index ){
          return WalletItem(wallet: walletList[index],index:index ,);
        } ,itemCount:  walletList.length , )
          :NoThingToShow(),);  }

}