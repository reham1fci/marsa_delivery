import 'package:flutter/material.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_images.dart';

class AppDrawerHeader extends StatelessWidget{
String? userName  ;

AppDrawerHeader(this.userName);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return  SizedBox(
       height: 250, child:DrawerHeader(

     decoration:  const BoxDecoration(
       color: AppColors.white,
     ),
     child:
         Container(
           height: 250,
           color: AppColors.white,
           child:
     Column(
       children: [
         CircleAvatar(
           radius: 56,
           child: ClipOval(child: Image.asset(Images.logo  , height: 110)),
         ) ,

         Text(userName! ,style: TextStyle(),)
       ],
     ),
         ) ,));
}}