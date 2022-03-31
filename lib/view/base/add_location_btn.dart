import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';

class AddLocationBtn extends StatelessWidget{
   Function onClick ;

   AddLocationBtn( {required this.onClick});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextButton.icon(onPressed: ()=> onClick(),
        icon: Icon(Icons.pin_drop), label:Text( getTranslated("add_location", context)??"") );
  }
}