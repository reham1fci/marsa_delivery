import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/Shipment.dart';
import 'package:marsa_delivery/model/salary.dart';
import 'package:marsa_delivery/model/violation.dart';
import 'package:marsa_delivery/model/wallet.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';

class   ReturnShipmentItem  extends StatelessWidget{
  Shipment? ship ;
  Function? onTap   ;

  ReturnShipmentItem({this.ship, this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  GestureDetector(
     //   onTap:()=>onTap!() ,
    child:Card(

      child:  Column(

        children: <Widget>[
          Padding(padding: EdgeInsets.all(10.0) , child:   Row(

              children: <Widget>[
                Text((getTranslated("num", context)??"")+" : "  ,style: TextStyle(color: AppColors.logRed)), Text(ship!.disId!,style: TextStyle(color: AppColors.logRed)),

                Spacer() ,
                // Icon(Icons.date_range ,color: AppColors.logRed,) ,
                Text(ship!.date!,style: TextStyle(color: AppColors.logRed))
              ]),),
          Divider(color: AppColors.logRed,thickness: 1,),
          Padding(padding: EdgeInsets.all(10.0) , child:     Row(children: <Widget>[
            Text("${getTranslated("driver_name", context)??""} : "), Text(ship!.driverNm!)]),),
          Padding(padding: EdgeInsets.all(10.0) , child:   Row(children: <Widget>[
            Text((getTranslated("product_name", context)??"")+" : " ), Text(ship!.productName!)]),),
          Padding(padding: EdgeInsets.all(10.0) ,child:  Row(children: <Widget>[
            Text((getTranslated("qty", context)??"" )+" : " ,), Text(ship!.qty!
            ) ,Spacer() ,CustomBtn(buttonNm:
            getTranslated("receive", context)??"", onClick: () => onTap!() ,  backBtn:AppColors.logRed, txtColor: AppColors.white,),]),),
        ], ),

      color: AppColors.white ,
      //RoundedRectangleBorder, BeveledRectangleBorder, StadiumBorder
      shape:  const RoundedRectangleBorder(
        side: BorderSide(color: AppColors.logRed, width: 1),

        borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10.0),
            top: Radius.circular(10.0)),
      ) ,
    ));

  }
}