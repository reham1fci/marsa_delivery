import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget{
   String buttonNm ;
    Function onClick ;
    Color backBtn  ;
    Color txtColor  ;
   CustomBtn({required this.buttonNm  , required this.backBtn ,required this.txtColor , Key? key,  required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
       Padding(
        padding:
       const EdgeInsets.only(bottom: 8.0, left: 40.0, right: 40.0, top: 8.0),
    child: Align(
    alignment: Alignment.bottomCenter,
    child:  Container(
    decoration:  BoxDecoration(
    color:backBtn,
    borderRadius: const BorderRadius.all(
     Radius.circular(8.0),
    )),
    width: double.infinity,
    child:

      TextButton(
      onPressed:()=> onClick(),

      child:
        // child:
           Text(
            buttonNm,
            style:   TextStyle(color:txtColor ,fontWeight: FontWeight.bold),
            textAlign:  TextAlign.center,
          ) ,

    )))  );


  }
}