import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/Shipment.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/utill/app_color.dart';

import '../shipment_return.dart';

class DeliveryShipItem extends StatelessWidget{
  User? delivery ;
  Function? onTap   ;
  Color cardColor  = AppColors.white ;

  DeliveryShipItem({this.delivery, this.onTap});

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return  GestureDetector(
       // onTap:()=>onTap!() ,
        child :  Padding(padding: const EdgeInsets.only(top: 8.0  , bottom:  8.0  , right: 16.0 , left:  16.0 )  ,
            child :    Card(

              child:  Padding(child: Column(

                children: <Widget>[

                  Row(

                      children: <Widget>[
                       Container(width:120,child: Align(child:  Text(delivery!.name! , maxLines: 2,
                            overflow: TextOverflow.ellipsis) ,alignment: Alignment.centerLeft,)),
                        Spacer() ,
                        Text('${getTranslated("qty", context)??""}  :' ,) ,
                        Align(child:  Text(delivery!.shipmentQty!  , style:  TextStyle(color: AppColors.logRed),) ,alignment: Alignment.centerRight,),
                        Spacer() ,
                        TextButton(onPressed:()=>onTap!()
                      ,child: Text(getTranslated("details", context)??"",style: TextStyle(color: AppColors.logRed),)),
                      ]),
                ],),padding: EdgeInsets.all(10.0), ),

              color: cardColor ,
              //RoundedRectangleBorder, BeveledRectangleBorder, StadiumBorder
              shape:  const RoundedRectangleBorder(
                side: BorderSide(color: AppColors.logRed, width: 1),

                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10.0),
                    top: Radius.circular(10.0)),
              ) ,

            ) ));
  }
}