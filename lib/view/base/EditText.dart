import 'package:flutter/material.dart';
import 'package:marsa_delivery/utill/app_color.dart';

class EditText extends StatelessWidget{
  String hint  ;
  String error  ;
  IconData image   ;
  TextEditingController edTxtController  ;
 Color edTextColor  ;

  EditText({required this.hint,   required this.edTextColor , required  this.error,required this.image,required this.edTxtController , Key? key}): super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Padding(padding: const EdgeInsets.only(bottom: 8.0 , left: 30.0  , right: 30.0 , top: 8.0) ,
      child:   TextField(controller:  edTxtController,
          decoration: InputDecoration(
            hintText: hint ,
            hintStyle: TextStyle(color: AppColors.greyDark),
            fillColor: Colors.white,
            filled: false,
            errorText: error,
            prefixIcon:Icon(image ,color: AppColors.white,),
          ) , style:  TextStyle(color: edTextColor) ,
      ),)

    ;  }
}