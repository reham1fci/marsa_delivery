import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/custody.dart';
import 'package:marsa_delivery/model/salary.dart';
import 'package:marsa_delivery/model/wallet.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';

class   CustodyItem  extends StatelessWidget{
  Custody custody ;
  int index ;
  Function? onReceiveClick ;
  Function? onRejectClick ;


  CustodyItem({ required this.custody,  required this.index ,this.onReceiveClick ,this.onRejectClick});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   Padding(padding: EdgeInsets.all(10.0) ,child: Card(

      child:Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(10.0) , child:   Row(

              children: <Widget>[
                Text((getTranslated("custody", context)??"")+" : "  ,style: TextStyle(color: AppColors.logRed)), Text(custody.id!,style: TextStyle(color: AppColors.logRed)),

                Spacer() ,
                // Icon(Icons.date_range ,color: AppColors.logRed,) ,
                Text(custody.date!,style: TextStyle(color: AppColors.logRed))
              ]),),
          Divider(color: AppColors.logRed,thickness: 1,),
          Padding(padding: EdgeInsets.all(10.0) , child:          Row(children: <Widget>[
            Text('${getTranslated("from", context)??"" } : '  ,), Text(custody.senderNm!)]),),
          Padding(padding: EdgeInsets.all(10.0) , child:       Row(children: <Widget>[
            Text('${getTranslated("money_amount", context)??"" } : '  ,), Text(custody.amount!)])),
          Padding(padding: EdgeInsets.all(10.0) , child:       Row(children: <Widget>[
            Text('${getTranslated("custody_type", context)??"" } : '  ,), Text(custody.state!)])),
          Padding(padding: EdgeInsets.all(10.0) , child:       Row(children: <Widget>[
            Text('${getTranslated("details", context)??"" } : '), Text(custody.details!)])),

       Padding(padding: EdgeInsets.all(10) , child: Row(children: <Widget>[
         CustomBtn(buttonNm: getTranslated("receive", context)??"", onClick:()=> onReceiveClick!() ,
           backBtn:AppColors.logRed, txtColor: AppColors.white,) ,
         Spacer(),
         CustomBtn(buttonNm: getTranslated("reject", context)??"", onClick:()=> onRejectClick!() ,
           backBtn:AppColors.logRed, txtColor: AppColors.white,)
       ])),

        ],),

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