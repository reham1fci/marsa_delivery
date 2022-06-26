import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/custody.dart';
import 'package:marsa_delivery/model/holiday.dart';
import 'package:marsa_delivery/model/thechief_request.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';

class   HolidayItem  extends StatelessWidget{
  Holiday req ;
  int index ;
  Function? onTap ;


  HolidayItem({ required this.req,  required this.index ,this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   Padding(padding: EdgeInsets.all(10.0) ,child: Card(

      child:Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(10.0) , child:          Row(children: <Widget>[
            Text('${getTranslated("holiday_num", context)??"" } : '  ,), Text(req.holidayNum!) ,
            Spacer() ,
            Text('${getTranslated("status", context)??"" } : '  ,style: TextStyle(color: AppColors.logRed),), Text(req.status!,style: TextStyle(color: AppColors.logRed),),



          ]),),
          Padding(padding: EdgeInsets.all(10.0) , child:          Row(children: <Widget>[
            Text('${getTranslated("from", context)??"" } : '  ,style: TextStyle(color: AppColors.logRed),), Text(req.from!) ,
            Spacer() ,
            Text('${getTranslated("to", context)??"" } : '  ,style: TextStyle(color: AppColors.logRed),), Text(req.to!),



          ]),),
          Padding(padding: EdgeInsets.all(10.0) , child: Row(children: <Widget>[
            Text('${getTranslated("reason", context)??"" } : ',),Flexible(child:Text(req.reason! ,
              overflow: TextOverflow.visible,)
            )])) ,
        ],),

      color: AppColors.white ,
      //RoundedRectangleBorder, BeveledRectangleBorder, StadiumBorder
      shape:  const RoundedRectangleBorder(
        //side: BorderSide(color: AppColors.logRed, width: 1),

        borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10.0),
            top: Radius.circular(10.0)),
      ) ,
    ));

  }

}