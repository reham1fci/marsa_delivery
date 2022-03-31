import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/Shipment.dart';
import 'package:marsa_delivery/utill/app_color.dart';

class QtyItem extends StatelessWidget{
   Shipment? ship ;
   Function? onTap   ;

   QtyItem({this.ship, this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  GestureDetector(
        onTap:()=>onTap ,
        child :  Padding(padding: const EdgeInsets.only(top: 8.0  , bottom:  8.0  , right: 16.0 , left:  16.0 )  ,
            child :    Card(

              child:  Padding(child: Column(

                children: <Widget>[

                  Row(

                      children: <Widget>[
                        Align(child:  Text(ship!.productName!) ,alignment: Alignment.centerLeft,),
                        Spacer() ,
                        Text('${getTranslated("qty", context)??""}  :' ,) ,
                        Align(child:  Text(ship!.qty!  , style:  TextStyle(color: AppColors.logRed),) ,alignment: Alignment.centerRight,),

                      ]),
                ],),padding: EdgeInsets.all(10.0), ),

              color: AppColors.white ,
              //RoundedRectangleBorder, BeveledRectangleBorder, StadiumBorder
              shape:const  RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10.0),
                    top: Radius.circular(10.0)),
              ),

            ) ));
  }
}