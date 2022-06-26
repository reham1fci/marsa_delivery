
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/target.dart';
import 'package:marsa_delivery/utill/app_color.dart';

class TargetView extends StatelessWidget {
  Target target  ;

  TargetView(this.target);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
   Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(padding: EdgeInsets.only(top: 30 ,bottom: 15),child:Text(getTranslated("target", context)??"" , style:  TextStyle(color: AppColors.logRed,fontSize: 17 ,) ,),),

      Container(
        width: double.infinity,
        //margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              borderRadius:const BorderRadius.vertical(
                bottom: Radius.circular(10.0),
                top: Radius.circular(10.0),
              ) ,
              border: Border.all(color: AppColors.logRed)) ,


          child:  Table(

              children: [
                tableRow(getTranslated("daily", context)??"", getTranslated("weekly", context)??"", getTranslated("monthly", context)??"", AppColors.logRed) ,
                tableRow2(target.yourDailyTarget!, target.yourWeeklyTarget!, target.yourMonthlyTarget!, Colors.black) ,
                tableRow(getTranslated("required", context)??"", getTranslated("required", context)??"", getTranslated("required", context)??"", Colors.black) ,
                tableRow2(target.requiredDailyTarget!, target.requiredWeeklyTarget!, target.requiredMonthlyTarget!, Colors.black) ,
              ],
            )



      )
     ]);
  }
  TableRow tableRow( String  text1 ,String text2 , text3 , Color color ){
    return  TableRow(
        children: [

         Text(text1, style: TextStyle(color: color,), textAlign: TextAlign.start,),
          Text(text2, style: TextStyle(color: color), textAlign: TextAlign.center,),
    Text(text3, style: TextStyle(color: color), textAlign: TextAlign.end,),

        ]);
  }
  TableRow tableRow2( String  text1 ,String text2 , text3 , Color color ){
    return  TableRow(
        children: [

          Padding(padding: EdgeInsets.only(left: 10 ,right: 10),child: Text(text1, style: TextStyle(color: color,), textAlign: TextAlign.start,)),
          Text(text2, style: TextStyle(color: color), textAlign: TextAlign.center,),
          Padding(padding: EdgeInsets.only(left: 10 ,right: 10),child:  Text(text3, style: TextStyle(color: color), textAlign: TextAlign.end,)),

        ]);
  }
}