import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/view/screens/cars/deliver_car_req.dart';
import 'package:marsa_delivery/view/screens/requests/financial_list.dart';
import 'package:marsa_delivery/view/screens/requests/thechief_request_list.dart';

class CarsOption extends StatelessWidget{
  const CarsOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            iconTheme:  const IconThemeData(color: AppColors.appBarIcon),
            centerTitle: true,
            systemOverlayStyle:const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: AppColors.statusAppBar,),
            backgroundColor: AppColors.appBar,title:Text( getTranslated("cars", context)??"",style: const TextStyle(color: AppColors.logRed),) ) ,
        body:
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(15),child:   TextButton(child: Text( getTranslated("deliver_car_req", context)??"",style: const TextStyle(color: AppColors.logRed ,fontSize: 20),)
                ,onPressed:(){
                  Navigator.push( context,
                      MaterialPageRoute(builder: (context) =>  DeliverCarReq())) ;
                } ,),),
              Divider() ,
              Padding(
                  padding: EdgeInsets.all(15),child:    TextButton(child: Text( getTranslated("receipt_car_req", context)??"",style: const TextStyle(color: AppColors.logRed ,fontSize: 20),)
                ,onPressed:(){
                  Navigator.push( context,
                      MaterialPageRoute(builder: (context) => FinancialList())) ;

                } ,)),
              Divider() ,

          /*    Padding(
                padding: EdgeInsets.all(15),child:     TextButton(child: Text( getTranslated("vacation_request", context)??"",style: const TextStyle(color: AppColors.logRed ,fontSize: 20),)
                  ,onPressed:(){
                    Navigator.push( context,
                        MaterialPageRoute(builder: (context) =>  HolidayList())) ;

                  } ),),
              Divider() ,

              Padding(
                padding: EdgeInsets.all(15),child:     TextButton(child: Text( getTranslated("custody_req", context)??"",style: const TextStyle(color: AppColors.logRed ,fontSize: 20),)
                  ,onPressed:(){
                    Navigator.push( context,
                        MaterialPageRoute(builder: (context) =>  CustodyList())) ;

                  } ),),*/
            ]) );
  }
}