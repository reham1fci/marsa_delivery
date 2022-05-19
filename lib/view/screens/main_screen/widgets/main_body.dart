import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/utill/app_images.dart';
import 'package:marsa_delivery/utill/app_strings.dart';
import 'package:marsa_delivery/view/base/bottom_nav_bar.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';
import 'package:marsa_delivery/view/base/drawer.dart';
import 'package:marsa_delivery/view/base/get_current_location.dart';
import 'package:marsa_delivery/view/screens/clients/clients.dart';
import 'package:marsa_delivery/view/screens/custody/custody_delivery.dart';
import 'package:marsa_delivery/view/screens/custody/custody_receive.dart';
import 'package:marsa_delivery/view/screens/main_screen/salary_view.dart';
import 'package:marsa_delivery/view/screens/main_screen/user_profile.dart';
import 'package:marsa_delivery/view/screens/main_screen/violation_view.dart';
import 'package:marsa_delivery/view/screens/main_screen/wallet_view.dart';
import 'package:marsa_delivery/view/screens/main_screen/widgets/pi_chart.dart';
import 'package:marsa_delivery/view/screens/points_sale/show_clients_view.dart';
import 'package:marsa_delivery/view/screens/receipt_delivery/receipt_delivery.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainBody extends StatefulWidget{
  const MainBody({Key? key}) : super(key: key);

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  CurrentLoc currentLoc  = CurrentLoc() ;
  Api api = Api() ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
getUserData() ;

  }
  getUserData() async {
    SharedPreferences  shared = await SharedPreferences.getInstance();
   User user = User.fromJsonShared(json.decode(shared.getString("user")!));


    currentLoc.getCurrentLocation(onGetLocation:(lat , lng){
      print(lat);
      print(lng)  ;

user.lat  = lat.toString() ;
user.lng  = lng.toString() ;
user.createLocation  = Api.getDate('yyyy-MM-dd  H:m:s aa') ;
api.request(url: Constants.getDriverLocation, map: user.addLocationToMap(), onSuccess: onLocationAdded, onError: onError) ;

    } );

  }

   onLocationAdded( var jsonObj){
    print(jsonObj) ;
   }
   onError(String err){
    print(err) ;
   }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
return Scaffold(
  appBar: AppBar(
      iconTheme: IconThemeData(color: Colors.grey),
      backgroundColor: AppColors.white  ,
      centerTitle: true,
    systemOverlayStyle:const SystemUiOverlayStyle(
      // Status bar color
      statusBarColor: AppColors.statusAppBar,),
      title: Image.asset(Images.sLogo , width: 70,height:70,),),
  body:  Padding(padding: EdgeInsets.all(15),child: SingleChildScrollView(child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      PiChart(),
      Padding(padding: EdgeInsets.only(top: 30 ,bottom: 15),child:Text(getTranslated("attendance", context)??"" , style:  TextStyle(color: AppColors.logRed,fontSize: 17 ,) ,),),
      GestureDetector(
          onTap: () {}, // Image tapped
          child:Container(
            width: double.infinity,
              height: 150,
              //margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                /* image: DecorationImage(
                  image: AssetImage(  Images.attendance ,),
                //  fit: BoxFit.cover,
                ),*/
                  borderRadius:const BorderRadius.vertical(
                    bottom: Radius.circular(10.0),
                    top: Radius.circular(10.0),
                  ) ,
                  border: Border.all(color: AppColors.logRed)) ,
             child:Row(
               children: [
                 Image.asset(
                   Images.attendance,
                   fit: BoxFit.cover, // Fixes border issues
                 ),
                 Spacer() ,
                 Column(
               mainAxisAlignment: MainAxisAlignment.end,
               crossAxisAlignment: CrossAxisAlignment.end,
               children: [

            Padding(padding: EdgeInsets.all(15) , child:   Text(getTranslated("active", context)??"" ,style: TextStyle(fontSize: 17),) ,),
               Spacer() ,
                 TextButton(child: Text(getTranslated("change_status", context)??"" , style:
                 TextStyle(color: Colors.white),),onPressed:null,style:
                 ButtonStyle(backgroundColor:MaterialStateProperty.all(AppColors.logRed,)))
             ],),

               ],
             )   )) ,
    Padding(padding: EdgeInsets.only(top: 30 ,bottom: 15),child:Text(getTranslated("custody", context)??"" , style:  TextStyle(color: AppColors.logRed,fontSize: 17 ,) ,),),
   GestureDetector(
        onTap: () {
          Navigator.push( context,
              MaterialPageRoute(builder: (context) => CustodyView())) ;
        }, // Image tapped
        child: Image.asset(
          Images.custody,
          fit: BoxFit.cover, // Fixes border issues
        ),
      ) ,
      Padding(padding: EdgeInsets.only(top: 30 ,bottom: 15),child:Text(getTranslated("clients", context)??"" , style:  TextStyle(color: AppColors.logRed,fontSize: 17 ,) ,),),
      GestureDetector(
        onTap: () {
          Navigator.push( context,
              MaterialPageRoute(builder: (context) => ClientsView())) ;
        }, // Image tapped
        child: Image.asset(
          Images.clients,
          fit: BoxFit.cover, // Fixes border issues
        ),
      ) ,
      Padding(padding: EdgeInsets.only(top: 30 ,bottom: 15),child:Text(getTranslated("point_sale", context)??"" , style:  TextStyle(color: AppColors.logRed,fontSize: 17 ,) ,),),
      GestureDetector(
        onTap: () {
          Navigator.push( context,
              MaterialPageRoute(builder: (context) => ShowClients())) ;
        }, // Image tapped
        child: Image.asset(
          Images.point_sale,
          fit: BoxFit.cover, // Fixes border issues
        ),
      ) ,
      Padding(padding: EdgeInsets.only(top: 30 ,bottom: 15),child:Text(getTranslated("receipt_delivery", context)??"" , style:  TextStyle(color: AppColors.logRed,fontSize: 17 ,) ,),),
      GestureDetector(
        onTap: () {
          Navigator.push( context,
              MaterialPageRoute(builder: (context) => ReceiptDelivery())) ;
        }, // Image tapped
        child: Image.asset(
          Images.receipt_delivery,
          fit: BoxFit.cover, // Fixes border issues
        ),
      ) ,
 /* CustomBtn(buttonNm: getTranslated("profile", context)??"", backBtn: AppColors.logRed, txtColor: AppColors.white, onClick: (){
    Navigator.push( context,
        MaterialPageRoute(builder: (context) => Profile())) ;
  }),
      CustomBtn(buttonNm: getTranslated("salary", context)??"", backBtn: AppColors.logRed, txtColor: AppColors.white, onClick: (){
        Navigator.push( context,
            MaterialPageRoute(builder: (context) => SalaryView())) ;
      }),
      CustomBtn(buttonNm: getTranslated("wallet", context)??"", backBtn: AppColors.logRed, txtColor: AppColors.white, onClick: (){
        Navigator.push( context,
            MaterialPageRoute(builder: (context) => WalletView())) ;
      }),
      CustomBtn(buttonNm: getTranslated("violation", context)??"", backBtn: AppColors.logRed, txtColor: AppColors.white, onClick: (){
        Navigator.push( context,
            MaterialPageRoute(builder: (context) => ViolationView())) ;
      }),
      CustomBtn(buttonNm: getTranslated("add_custody", context)??"", backBtn: AppColors.logRed, txtColor: AppColors.white, onClick: (){
        Navigator.push( context,
            MaterialPageRoute(builder: (context) => CustodyView())) ;
      }),*/
    ])),
  ),
  bottomNavigationBar: AppBottomNavBar(),
  drawer: AppDrawer()
) ; }
}