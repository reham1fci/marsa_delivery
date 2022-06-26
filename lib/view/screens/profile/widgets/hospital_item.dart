import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marsa_delivery/model/hosiptal.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_images.dart';

class   HospitalItem  extends StatelessWidget{
  Hospital req ;
  int index ;
  Function? onTap ;


  HospitalItem({ required this.req,  required this.index ,this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   Padding(padding: EdgeInsets.all(5.0) ,child: Card(

      child:Column(
        children: <Widget>[
      Padding(padding: EdgeInsets.all(10)   ,child:TextButton.icon(icon:Image.asset(Images.location,width: 25,height: 25,),label: Text(req.hospitalNm!,style: TextStyle(color: Colors.black),),onPressed:null)),
      Padding(padding: EdgeInsets.all(10)   ,child:TextButton.icon(icon:Image.asset(Images.location,width: 25,height: 25,),label: Text(req.hospitalType!,style: TextStyle(color: Colors.black),),onPressed:null)),
      Padding(padding: EdgeInsets.all(10)   ,child:TextButton.icon(icon:Image.asset(Images.location,width: 25,height: 25,),label: Text(req.location!,style: TextStyle(color: Colors.black),),onPressed:null)),



    ],),

      color: AppColors.white ,
      //RoundedRectangleBorder, BeveledRectangleBorder, StadiumBorder
      shape:  const RoundedRectangleBorder(
        //side: BorderSide(color: AppColors.logRed, width: 1),

        borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10.0),
            top: Radius.circular(10.0)),
      ) ,
    ));

  }

}