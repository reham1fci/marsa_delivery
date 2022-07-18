import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/utill/app_color.dart';

class DrawerExpandItem extends StatelessWidget {
  Widget icon;
  String text;

  List<Widget>subMenu;

  DrawerExpandItem(
      {required this.icon, required this.text, required this.subMenu});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ExpansionTile(
        title: Row(children: [
          Padding(padding: EdgeInsets.only(left: 5), child: icon),
          Text(getTranslated(text, context)??"", style: const TextStyle(color: AppColors.white),),
        ]

        ),
        children: subMenu ,
      backgroundColor: Colors.black,

      iconColor:AppColors.white ,

      /*<Widget>[
       TextButton(child:Text(AppLocalizations.of(context)?.translate("balances") ?? "" ,style: const TextStyle(color: MyColors.white)),onPressed: (){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  AccBalance()));

       },),
       TextButton(child: Text(AppLocalizations.of(context)?.translate("receipts_payments") ?? "",style: const TextStyle(color: MyColors.white)),onPressed: (){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>   AccReceiptsPayments()));

       },),
       TextButton(child:   Text(AppLocalizations.of(context)?.translate("month_receipts_payments") ?? "",style: const TextStyle(color: MyColors.white)),onPressed: (){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  AccMonthReceiptsPayments()));

       }),
     ],*/
    );
  }
}