import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/utill/app_color.dart';

class DrawerItem extends StatelessWidget{
  Widget icon ;
  String text  ;
  Function onTap  ;


  DrawerItem({required this.icon, required this.text,  required this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(padding: EdgeInsets.only(top: 10 , bottom: 10), child:ListTile(
      title: Row(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(left: 5), child: icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(getTranslated(text, context)??"" ),
          )
        ],
      ),
      onTap:()=> onTap()
    ));
  }
  }
