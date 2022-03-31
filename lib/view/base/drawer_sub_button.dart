import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/utill/app_color.dart';

class SubButton extends StatelessWidget{
String text  ;
Function onTap  ;


SubButton({required  this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return        TextButton(child:Text(getTranslated(text , context) ?? "" ,style: const TextStyle(color: AppColors.offWhit)),onPressed:()=> onTap());

}}