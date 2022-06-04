import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/Shipment.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/view/base/alert_dialog.dart';

class ShipmentItem extends StatefulWidget{
 Function onGet ;
  Shipment obj  ;
   User? user ;
   Function onRefresh ;
   bool enableBtn  ;
  ShipmentItem({Key? key, required this.onGet , required this.obj  ,  this.user  , required this.onRefresh , required this.enableBtn}) : super(key: key);

  @override
  State<ShipmentItem> createState() => ShipmentItemState();
}

class ShipmentItemState extends State<ShipmentItem> {
   Color cardColor  = AppColors.white ;
   List<Shipment> selectedShip  =[] ;
Api api = Api() ; 
  @override
  Widget build(BuildContext context) {
    if(widget.obj.isSelected!){cardColor =AppColors.grey ;}
    else{cardColor=AppColors.white;
    }
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
                  widget.enableBtn?   Row(children: <Widget>[
                    Text('${getTranslated("shipment_num", context)??""}  :' ,
                      style: TextStyle(color: AppColors.logRed),),Text(widget.obj.shipNum!),
                      ]):SizedBox(),  Row(children: <Widget>[
                    Text('${getTranslated("qty", context)??""}  :' , style: TextStyle(color: AppColors.logRed),),Text(widget.obj.qty!),
                Spacer() ,   widget.enableBtn?  TextButton(child: Text(getTranslated("ship_not_found", context)??"" , style:
                    TextStyle(color: Colors.white),),onPressed:onNotFoundShip,style:
                    ButtonStyle(backgroundColor:MaterialStateProperty.all(AppColors.logRed,))):SizedBox(),
                      ]),
                ],),padding: EdgeInsets.all(10.0), ),

              color:cardColor ,
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
   changeCardColor(){
    setState(() {
      cardColor=AppColors.grey;

    });
   }

onNotFoundShip(){
CustomDialog.dialog(context: context, title: getTranslated("ship_not_found", context)??"", message: getTranslated("confirm_ship_not_found", context)??"", isCancelBtn: true , onOkClick: (){
onConfirmShipNotFound() ;
} , onCancelClick: (){

}) ;
}
onConfirmShipNotFound(){
    Map m = widget.obj.toJson() ;
    m["user_id"] = widget.user!.userId! ;
    print(m) ;
    api.request(url: Constants.SHIP_NOT_FOUND, map: m, onSuccess: onSuccessRequest, onError: onError) ;
}
 onSuccessRequest(var jsonObj){
   var jsonStr = json.decode(jsonObj);
   print(jsonStr) ;
   String  msg  = jsonStr['msg']  ;
   print(msg) ;
   if(msg== "تمت العملية بنجاح") {
     CustomDialog.dialog(context: context, title: "", message: msg, isCancelBtn: false , onOkClick: (){
       widget.onRefresh() ;
     }) ;
   }else{
     CustomDialog.dialog(context: context, title: "", message: msg, isCancelBtn: false) ;
     }
 }
  onError(String err){
    CustomDialog.dialog(context: context, title: "", message: err, isCancelBtn: false );  }
}