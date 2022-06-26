import 'package:flutter/material.dart';

class CustomBtnWoutPadd extends StatelessWidget{
   String buttonNm ;
    Function onClick ;
    Color backBtn  ;
    Color txtColor  ;
   CustomBtnWoutPadd({required this.buttonNm  , required this.backBtn ,required this.txtColor , Key? key,  required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Center(child:Container(
    decoration:  BoxDecoration(
    color:backBtn,
    borderRadius: const BorderRadius.all(
     Radius.circular(8.0),
    )),
  //  width: double.infinity,
    child:
    Padding(
        padding:
        const EdgeInsets.only( left: 5.0, right: 5.0, ),
    child:  TextButton(
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