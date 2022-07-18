import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/salary.dart';
import 'package:marsa_delivery/model/wallet.dart';
import 'package:marsa_delivery/utill/app_color.dart';

class   WalletItem  extends StatelessWidget{
  Wallet wallet ;
  int index ;

  WalletItem({ required this.wallet,  required this.index});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   Card(

      child:Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(10.0) , child:   Row(

                    children: <Widget>[
                      Text((getTranslated("wallet", context)??"")+" : "  ,style: TextStyle(color: AppColors.logRed)), Text(wallet.walletId!,style: TextStyle(color: AppColors.logRed)),

                      Spacer() ,
                      // Icon(Icons.date_range ,color: AppColors.logRed,) ,
                      Text(wallet.date!,style: TextStyle(color: AppColors.logRed))
                    ]),),
    Divider(color: AppColors.logRed,thickness: 1,),
    Padding(padding: EdgeInsets.all(10.0) , child:          Row(children: <Widget>[
                  Text('${getTranslated("name", context)??"" } : '  ,), Text(wallet.name!)]),),
    Padding(padding: EdgeInsets.all(10.0) , child:       Row(children: <Widget>[
                Text('${getTranslated("credit", context)??"" } : '  ,), Text(wallet.credit!)])),
    Padding(padding: EdgeInsets.all(10.0) , child:       Row(children: <Widget>[
            Text('${getTranslated("debit", context)??"" } : '), Text(wallet.debit!)])),
    Padding(padding: EdgeInsets.all(10.0) , child:        Row(children: <Widget>[
            Text('${getTranslated("balance", context)??"" } : ' ), Text(wallet.balance!.toString()
            )])),
    Padding(padding: EdgeInsets.all(10.0) , child:        Row(children: <Widget>[
            Text('${getTranslated("details", context)??"" } : ',),Flexible(child:Text(wallet.details! ,
    overflow: TextOverflow.visible,)
            )])),
        ],),

      color: AppColors.white ,
      //RoundedRectangleBorder, BeveledRectangleBorder, StadiumBorder
      shape:  const RoundedRectangleBorder(
        side: BorderSide(color: AppColors.logRed, width: 1),

        borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10.0),
            top: Radius.circular(10.0)),
      ) ,
    );

  }
}