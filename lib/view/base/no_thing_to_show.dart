import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';

class NoThingToShow extends StatelessWidget{
  const NoThingToShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   Container(child:
     Center(
      child:   Column( children: <Widget>[
        //  Image.asset('images/nothing.png', fit: BoxFit.contain),
        Text (getTranslated("not_find_item", context)??"")
      ], mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,),
    ) , height: double.infinity, ) ;
  }
  }
