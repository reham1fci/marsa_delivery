import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/Shipment.dart';
import 'package:marsa_delivery/utill/app_color.dart';

class ShipmentItem extends StatefulWidget{
 Function onGet ;
  Shipment obj  ;
  ShipmentItem({Key? key,  required this.onGet , required this.obj }) : super(key: key);

  @override
  State<ShipmentItem> createState() => _ShipmentItemState();
}

class _ShipmentItemState extends State<ShipmentItem> {
   Color cardColor  = AppColors.white ;
   List<Shipment> selectedShip  =[] ;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  GestureDetector(
        onTap:onTap ,
        child :  Padding(padding: const EdgeInsets.only(top: 8.0  , bottom:  8.0  , right: 16.0 , left:  16.0 )  ,
            child :    Card(

        child:  Padding(child: Column(

                children: <Widget>[

                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: <Widget>[
                         Align(child:  Text(widget.obj.productName!) ,alignment: Alignment.centerLeft,),
                         Align(child:  Text(widget.obj.date!) ,alignment: Alignment.centerRight,),

                      ]),
                  Row(children: <Widget>[
                    Text('${getTranslated("shipment_num", context)??""}  :' ,
                      style: TextStyle(color: AppColors.logRed),),Text(widget.obj.shipNum!),
                      ]),  Row(children: <Widget>[
                    Text('${getTranslated("qty", context)??""}  :' , style: TextStyle(color: AppColors.logRed),),Text(widget.obj.qty!),
                      ]),
                ],),padding: EdgeInsets.all(10.0), ),

              color: cardColor ,
              //RoundedRectangleBorder, BeveledRectangleBorder, StadiumBorder
              shape:const  RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10.0),
                    top: Radius.circular(10.0)),
              ),

            ) ));
  }
   onTap(){
        if(widget.obj.isSelected!){
           setState(() {
             cardColor  = AppColors.white;
              widget.obj.isSelected  = false  ;
             selectedShip.remove(widget.obj) ;

           });
           widget.onGet(widget.obj , false ) ;

        }
         else{
          setState(() {
            cardColor  = AppColors.grey;
            widget.obj.isSelected  = true  ;
            selectedShip.add(widget.obj) ;
          });
          widget.onGet(widget.obj , true ) ;


  }

   }


}