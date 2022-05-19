import 'package:flutter/material.dart';
import 'package:marsa_delivery/model/salary.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_images.dart';

class SalaryItem extends StatelessWidget{
Salary userSalary ;
int index ;
Function onTap;

SalaryItem({ required this.userSalary,  required this.index, required this.onTap});

@override
  Widget build(BuildContext context) {
    // TODO: implement build
 return   GestureDetector(child: Card(

      child:  Padding(child: Column(

        children: <Widget>[

          Row(

              children: <Widget>[
                Image.asset(Images.money,width: 25,height: 25,), Text(userSalary.netSalary!)           ,

          Spacer() ,
                Image.asset(Images.date,width: 25,height: 25,), Text(userSalary.salaryDate!)               ]),
        ],),padding: EdgeInsets.all(10.0), ),

      color: AppColors.white ,
      //RoundedRectangleBorder, BeveledRectangleBorder, StadiumBorder
      shape:  const RoundedRectangleBorder(
        side: BorderSide(color: AppColors.logRed, width: 1),

        borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10.0),
            top: Radius.circular(10.0)),
      ) ,
 ),onTap:()=> onTap() ,);

  }
}