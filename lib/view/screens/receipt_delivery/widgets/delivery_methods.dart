import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';

class DeliveryMethods extends StatelessWidget{
  Function? onQrClick  ;
  Function? onDistanceClick  ;

  DeliveryMethods({this.onQrClick, this.onDistanceClick});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title:  const Text(""),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(getTranslated("delivery_methods", context)??""),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
            child:  Text(getTranslated("qrcode", context)??""),
            onPressed: ()=> onQrClick!()
        ),
        TextButton(
            child:  Text(getTranslated("in_customer_location", context)??""),
            onPressed:()=> onDistanceClick!() )

      ],
    );
  }
}