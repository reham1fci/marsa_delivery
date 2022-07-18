import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/custody.dart';
import 'package:marsa_delivery/model/salary.dart';
import 'package:marsa_delivery/model/wallet.dart';
import 'package:marsa_delivery/utill/app_color.dart';

class   CustodyDetailsItem  extends StatelessWidget{
  Custody custody ;
  int index ;

  CustodyDetailsItem({ required this.custody,  required this.index});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   Card(

      child:Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(10.0) , child:   Row(

              children: <Widget>[
                Text((getTranslated("custody", context)??"")+" : "  ,style: TextStyle(color: AppColors.logRed)), Text("",style: TextStyle(color: AppColors.logRed)),

                Spacer() ,
                // Icon(Icons.date_range ,color: AppColors.logRed,) ,
                Text(custody.date!,style: TextStyle(color: AppColors.logRed))
              ]),),
          Divider(color: AppColors.logRed,thickness: 1,),
          Padding(padding: EdgeInsets.all(10.0) , child:          Row(children: <Widget>[
            Text('${getTranslated("sender_name", context)??"" } : '  ,), Text(custody.senderNm!)]),),
          Padding(padding: EdgeInsets.all(10.0) , child:          Row(children: <Widget>[
            Text('${getTranslated("receive_name", context)??"" } : '  ,), Text(custody.receiver!)]),),
          Padding(padding: EdgeInsets.all(10.0) , child:       Row(children: <Widget>[
            Text('${getTranslated("credit", context)??"" } : '  ,), Text(custody.credit!)])),
          Padding(padding: EdgeInsets.all(10.0) , child:       Row(children: <Widget>[
            Text('${getTranslated("debit", context)??"" } : '), Text(custody.debit!)])),
          Padding(padding: EdgeInsets.all(10.0) , child:        Row(children: <Widget>[
            Text('${getTranslated("status", context)??"" } : ' ), Text(custody.state!.toString()
            )])),
          Padding(padding: EdgeInsets.all(10.0) , child:        Row(children: <Widget>[
            Text('${getTranslated("details", context)??"" } : ',),Flexible(child:Text(custody.details! ,
              overflow: TextOverflow.visible,)
            )])),
        ],),

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