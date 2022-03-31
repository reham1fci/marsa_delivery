
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/point_sale_client.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/view/base/alert_dialog.dart';
import 'package:marsa_delivery/view/base/map_show.dart';
import 'package:marsa_delivery/view/screens/PlacePicker/place_picker.dart';
import 'package:maps_launcher/maps_launcher.dart';


class ClientListItem extends StatefulWidget{
  int index ;
  List<PointSaleClient>list  = [] ;
  ClientListItem ({required this.index , required this.list ,Key? key}) : super(key: key);

  @override
  State<ClientListItem> createState() => _ClientListItemState();
}

class _ClientListItemState extends State<ClientListItem> {
   Api  api = Api() ;
  @override
  Widget build(BuildContext context) {
    PointSaleClient  client  =  widget.list [widget.index]  ;
    // TODO: implement build
    return   GestureDetector(
      child: Padding(padding:const EdgeInsets.all(5.0) ,child:Card(
        color: AppColors.white,
        //RoundedRectangleBorder, BeveledRectangleBorder, StadiumBorder
        shape:  const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10.0),
              top: Radius.circular(10.0)),
        ) ,
        child:Container(
            padding: const EdgeInsets.all(8),
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         Padding(padding: const EdgeInsets.all(5.0) ,child: Center(child:  Text(client.customerName!,  style :TextStyle( fontSize: 20))) ),
          Padding(padding: const EdgeInsets.all(5.0) ,child:      Row(
          children: [
           Icon(Icons.phone_android ,color: AppColors.logRed,) , Text(client.phone!) , Spacer()   ,
            TextButton.icon(icon:Icon(Icons.pin_drop ,color: AppColors.logRed),label: Text(getTranslated("client_loc", context)??"",),onPressed: (){

              if(client.lat!.isNotEmpty&& client.lng!.isNotEmpty){
                double lat  = double.parse(client.lat!) ;
                double lng  = double.parse(client.lng!) ;
                MapsLauncher.launchCoordinates(
                    lat, lng, getTranslated("client_loc", context)) ;
             // child: Text('LAUNCH COORDINATES')
              /*  Navigator.push( context,
                    MaterialPageRoute(builder: (context) =>  MapShow(LatLng(lat,lng)))) ;*/

              }
              else{
                Navigator.push( context,
                    MaterialPageRoute(builder: (context) => PlacePicker())).then((value ){
                  setState(() {
                    client.lat =   value["lat"].toString()  ;
                    client.lng =   value["lng"].toString()  ;
                    addCustomerLocation(client) ;
                    // save customer location  ;
                  });
                } );
              }
            },)




          ],) ) ,

            ],)),

      )) ,
      onTap: (){

      },
    )   ;
  }
   addCustomerLocation(PointSaleClient c ){
    Map m = <String,dynamic>{} ;
     m["customer_id"] = c.customerId  ;
     m["lat"] = c.lat  ;
     m["lng"] = c.lng  ;
    api.request(url: Constants.ADD_CustomerLoc, map: m, onSuccess: onSuccessAddedLocation, onError: onErr) ;
   }
    onSuccessAddedLocation( var jsonStr ){
      var jsonObj = json.decode(jsonStr);
       print(jsonObj) ;
      String  msg  = jsonStr['msg']  ;
if(msg== "تمت عملية اضافة موقع العميل بنجاح") {
  CustomDialog.dialog(context: context, title: "", message: msg, isCancelBtn: false) ;

}
 else{
  CustomDialog.dialog(context: context, title: getTranslated("error" , context)??"error", message: msg, isCancelBtn: false) ;

}
    }
    onErr(String err){
      CustomDialog.dialog(context: context, title: "", message: getTranslated("error" , context)??"error", isCancelBtn: false) ;

    }
}
