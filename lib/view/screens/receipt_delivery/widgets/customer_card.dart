
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/point_sale_client.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_images.dart';
import 'package:marsa_delivery/view/screens/PlacePicker/place_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerCard extends StatefulWidget{
  PointSaleClient client  ;

 CustomerCard(this.client);

  @override
  State<CustomerCard> createState() => _CustomerCardState();
}

class _CustomerCardState extends State<CustomerCard> {
  @override
  Widget build(BuildContext context) {
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
               Padding(padding: const EdgeInsets.all(5.0) ,
                   child:  Row( children: [Text(widget.client.customerName! ,style: TextStyle(fontSize: 17),) ,Spacer()
                       ] ) ),
               Padding(padding: const EdgeInsets.all(5.0) ,child:
               Row(children: [
                 IconButton(onPressed: () async {
                   var whatsappUrl ="whatsapp://send?phone=${widget.client.phone}";
                   // await canLaunch(whatsappUrl)?
                   launch(whatsappUrl);
                   //  :print("open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
                 }, icon: Image.asset(Images.whatsapp),),
                 TextButton.icon(icon:  Icon(Icons.phone_android ,color: AppColors.logRed,) ,label: Text(widget.client.phone!,style: TextStyle(color: Colors.black)) ,onPressed: (){
                   launch(('tel://${widget.client.phone}'));

                 },)                   , Spacer()   ,
                   TextButton.icon(icon:Icon(Icons.pin_drop ,color: AppColors.logRed),label: Text(getTranslated("client_loc", context)??"",),onPressed: (){
                     if(widget.client.lat!.isNotEmpty&& widget.client.lng!.isNotEmpty){
                       double lat  = double.parse(widget.client.lat!) ;
                       double lng  = double.parse(widget.client.lng!) ;
                       MapsLauncher.launchCoordinates(
                           lat, lng, getTranslated("client_loc", context)).then((value) {
                         print("mab") ;
                       //  widget.onRefresh!();
                       });
                     }
                     else{
                       Navigator.push( context,
                           MaterialPageRoute(builder: (context) => PlacePicker())).then((value ){
                         setState(() {
                           widget.client.lat =   value["lat"].toString()  ;
                           widget.client.lng =   value["lng"].toString()  ;
                         //  addCustomerLocation(item) ;
                           // save customer location  ;
                         });
                       } );
                     }
                   },)],) ) ,

             ],)),

     )) ,
     onTap: (){

     },
   );
  }
}