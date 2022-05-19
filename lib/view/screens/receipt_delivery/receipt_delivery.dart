import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/view/screens/clients/add_client_view.dart';
import 'package:marsa_delivery/view/screens/points_sale/add_clients_view.dart';
import 'package:marsa_delivery/view/screens/receipt_delivery/delivery_view.dart';
import 'package:marsa_delivery/view/screens/receipt_delivery/quantity_view.dart';
import 'package:marsa_delivery/view/screens/receipt_delivery/receipt_shipment.dart';

class ReceiptDelivery extends StatelessWidget{
  const ReceiptDelivery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            iconTheme:  const IconThemeData(color: AppColors.appBarIcon),
            centerTitle: true,
            systemOverlayStyle:const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: AppColors.statusAppBar,),
            backgroundColor: AppColors.appBar,title:Text( getTranslated("receipt_delivery", context)??"",style: const TextStyle(color: AppColors.logRed),) ) ,
        body:
         Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
         Padding(
         padding: EdgeInsets.all(15),child:   TextButton(child: Text( getTranslated("shipment_receipt", context)??"",style: const TextStyle(color: AppColors.logRed ,fontSize: 20),)
          ,onPressed:(){
            Navigator.push( context,
                MaterialPageRoute(builder: (context) => const ReceiptShipment())) ;
          } ,),),
    Divider() ,
    Padding(
    padding: EdgeInsets.all(15),child:    TextButton(child: Text( getTranslated("shipment_delivery", context)??"",style: const TextStyle(color: AppColors.logRed ,fontSize: 20),)
                  ,onPressed:(){
                    Navigator.push( context,
                        MaterialPageRoute(builder: (context) => const DeliveryView())) ;
                  } ,)),
                Divider() ,

                Padding(
    padding: EdgeInsets.all(15),child:     TextButton(child: Text( getTranslated("quantities", context)??"",style: const TextStyle(color: AppColors.logRed ,fontSize: 20),)
                  ,onPressed:(){
                    Navigator.push( context,
                        MaterialPageRoute(builder: (context) => const QuantityView())) ;
                  } ),),
         ]) );
  }
}