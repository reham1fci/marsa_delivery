import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/salary.dart';
import 'package:marsa_delivery/model/violation.dart';
import 'package:marsa_delivery/model/wallet.dart';
import 'package:marsa_delivery/utill/app_color.dart';

class   ViolationItem  extends StatelessWidget{
  Violation violation ;
  int index ;

  ViolationItem({ required this.violation,  required this.index});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   Card(

      child:  Column(

        children: <Widget>[
       Padding(padding: EdgeInsets.all(10.0) , child:   Row(

              children: <Widget>[
                Text((getTranslated("v_id", context)??"")+" : "  ,style: TextStyle(color: AppColors.logRed)), Text(violation.vId!,style: TextStyle(color: AppColors.logRed)),

                Spacer() ,
               // Icon(Icons.date_range ,color: AppColors.logRed,) ,
                Text(violation.vDate!,style: TextStyle(color: AppColors.logRed))
              ]),),
          Divider(color: AppColors.logRed,thickness: 1,),
          Padding(padding: EdgeInsets.all(10.0) , child:     Row(children: <Widget>[
            Text("${getTranslated("driver_name", context)??""} : "), Text(violation.name!)]),),
    Padding(padding: EdgeInsets.all(10.0) , child:   Row(children: <Widget>[
            Text((getTranslated("car_name", context)??"")+" : " ), Text(violation.carNm!)]),),
    Padding(padding: EdgeInsets.all(10.0) ,child:  Row(children: <Widget>[
            Text((getTranslated("v_cost", context)??"" )+" : " ,), Text(violation.vCost!
            )]),),
    Padding(padding: EdgeInsets.all(10.0) ,child:     Row(children: <Widget>[
            Text((getTranslated("v_details", context)??"")+" : "  ),Flexible(child:Text(violation.vDetails! ,
        overflow: TextOverflow.visible,)
            )])),
        ], ),

      color: AppColors.white ,
      //RoundedRectangleBorder, BeveledRectangleBorder, StadiumBorder
      shape:  const RoundedRectangleBorder(
        side: BorderSide(color: AppColors.logRed, width: 1),

        borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10.0),
            top: Radius.circular(10.0)),
      ) ,
    );

  }
}