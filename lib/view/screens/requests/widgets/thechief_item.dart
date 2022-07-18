import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/custody.dart';
import 'package:marsa_delivery/model/thechief_request.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';

class   TheChiefItem  extends StatelessWidget{
  TheChiefRequest req ;
  int index ;
  Function? onReceiveClick ;


  TheChiefItem({ required this.req,  required this.index ,this.onReceiveClick});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   Padding(padding: EdgeInsets.all(10.0) ,child: Card(

      child:Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(10.0) , child:   Row(

              children: <Widget>[
                Text((getTranslated("request", context)??"")+" : "  ,style: TextStyle(color: AppColors.logRed)), Text(req.orderNum!,style: TextStyle(color: AppColors.logRed)),

                Spacer() ,
                // Icon(Icons.date_range ,color: AppColors.logRed,) ,
                Text(req.date!,style: TextStyle(color: AppColors.logRed))
              ]),),
          Divider(color: AppColors.logRed,thickness: 1,),
          Padding(padding: EdgeInsets.all(10.0) , child:          Row(children: <Widget>[
            Text('${getTranslated("total_cost", context)??"" } : '  ,), Text(req.totalCost!)]),),
          Padding(padding: EdgeInsets.all(10.0) , child:       Row(children: <Widget>[
            Text('${getTranslated("order_cost", context)??"" } : '  ,), Text(req.orderCost!)])),
          Padding(padding: EdgeInsets.all(10.0) , child:       Row(children: <Widget>[
            Text('${getTranslated("deliver_cost", context)??"" } : '  ,), Text(req.deliverCost!)])),
          Padding(padding: EdgeInsets.all(10) , child:
          CustomBtn(buttonNm: getTranslated("receive", context)??"", onClick:()=> onReceiveClick!() ,
            backBtn:AppColors.logRed, txtColor: AppColors.white,)
          ),

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