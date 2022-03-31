
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_images.dart';
import 'package:marsa_delivery/view/base/drawer_expand_item.dart';
import 'package:marsa_delivery/view/base/drawer_header.dart';
import 'package:marsa_delivery/view/base/drawer_item.dart';
import 'package:marsa_delivery/view/base/drawer_sub_button.dart';
import 'package:marsa_delivery/view/screens/clients/add_client_view.dart';
import 'package:marsa_delivery/view/screens/login/login_view.dart';
import 'package:marsa_delivery/view/screens/points_sale/add_clients_view.dart';
import 'package:marsa_delivery/view/screens/points_sale/show_clients_view.dart';
import 'package:marsa_delivery/view/screens/receipt_delivery/delivery_view.dart';
import 'package:marsa_delivery/view/screens/receipt_delivery/quantity_view.dart';
import 'package:marsa_delivery/view/screens/receipt_delivery/receipt_shipment.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AppDrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return DrawerState();
  }

}
class DrawerState extends State<AppDrawer> {
  late SharedPreferences sharedPrefs ;
String userName= ""  ;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData() ;
  }
  getUserData() async {
    SharedPreferences  shared = await SharedPreferences.getInstance();
  User  user = User.fromJsonShared(json.decode(shared.getString("user")!));
 setState(() {
   userName  = user.name!  ;
 });

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Drawer(
     // Add a ListView to the drawer. This ensures the user can scroll
     // through the options in the drawer if there isn't enough vertical
     // space to fit everything.
     child:
         Container
           ( 
         color:AppColors.colorPrimary ,
         child:
     ListView(
       // Important: Remove any padding from the ListView.
       padding: EdgeInsets.zero,
       children: [
         AppDrawerHeader(userName),
DrawerExpandItem(icon: const Icon(Icons.group ,color: Colors.white,) ,text:"clients" , subMenu:<Widget> [
SubButton(text: "add_client", onTap: (){
  Navigator.push( context,
      MaterialPageRoute(builder: (context) => AddClient())) ;
}) ,
  ],),
       const  Divider(color: Colors.white,) ,

         DrawerExpandItem(icon: const Icon(Icons.point_of_sale ,color: Colors.white,) ,text:"point_sale" , subMenu:<Widget> [
SubButton(text: "add_clients", onTap: (){
  Navigator.push( context,
      MaterialPageRoute(builder: (context) => AddClients())) ;
}) ,
SubButton(text: "show_clients", onTap: (){
  Navigator.push( context,
      MaterialPageRoute(builder: (context) => ShowClients())) ;
}) ,
  ],),
          const Divider(color: Colors.white,) ,

         DrawerExpandItem(icon: const Icon(Icons.receipt_long, color: Colors.white,) ,text:"receipt_delivery" , subMenu:<Widget> [
SubButton(text: "shipment_receipt", onTap: (){
  Navigator.push( context,
      MaterialPageRoute(builder: (context) => const ReceiptShipment())) ;
}) ,
SubButton(text: "shipment_delivery", onTap: (){

  Navigator.push( context,
      MaterialPageRoute(builder: (context) => const DeliveryView())) ;
}) ,
SubButton(text: "quantities", onTap: (){Navigator.push( context,
    MaterialPageRoute(builder: (context) => const QuantityView())) ;}) ,
  ],),
        const  Divider(color: Colors.white,) ,
         DrawerItem(icon:const Icon(Icons.control_camera , color: AppColors.white), text: "performance", onTap: (){}),
        const  Divider(color: Colors.white,) ,

         DrawerItem(icon:const Icon(Icons.contact_phone , color: AppColors.white), text: "contact_us", onTap: (){}),
        const  Divider(color: Colors.white,) ,

         DrawerItem(icon:const Icon(Icons.logout , color: AppColors.white), text: "logout", onTap: () async {
             // delete user data shared
           sharedPrefs = await SharedPreferences.getInstance();

           sharedPrefs.clear() ;
             Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => Login()),
             );
         }),
       ],
     ),
         ));
  }

}