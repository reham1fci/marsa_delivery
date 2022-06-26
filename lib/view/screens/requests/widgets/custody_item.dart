import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/custody.dart';
import 'package:marsa_delivery/model/financial.dart';
import 'package:marsa_delivery/model/holiday.dart';
import 'package:marsa_delivery/model/thechief_request.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';
import 'package:marsa_delivery/view/base/custom_button_witout_padding.dart';

class   CustodyItem  extends StatelessWidget{
  Custody req ;
  int index ;
  Function? onAcceptTap ;


  CustodyItem({ required this.req,  required this.index ,this.onAcceptTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   Padding(padding: EdgeInsets.all(10.0) ,child: Card(

      child:Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(10.0) , child:          Row(children: <Widget>[
            Text('${getTranslated("num", context)??"" } : ' ,), Text(req.id!) ,
          ]),),
          Padding(padding: EdgeInsets.all(10.0) , child:          Row(children: <Widget>[
            Text('${getTranslated("money", context)??"" } : '  ), Text(req.amount!) ,
          ]),),
          Padding(padding: EdgeInsets.all(10.0) , child: Row(children: <Widget>[
            Text('${getTranslated("details", context)??"" } : ',),Flexible(child:Text(req.details! ,
              overflow: TextOverflow.visible,)
            )])) ,
          Padding(padding: EdgeInsets.all(10.0) , child:          Row(
              children: <Widget>[
            Text('${getTranslated("status", context)??"" } : ' ), Text(req.state!,style: TextStyle(color: AppColors.logRed),),
                Spacer() ,
            req.stateNum=="9"? CustomBtnWoutPadd(buttonNm: getTranslated("accept", context)??"", backBtn: AppColors.logRed, txtColor: Colors.white, onClick:()=> onAcceptTap!())
         :SizedBox() ]),),
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