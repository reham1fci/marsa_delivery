import 'package:flutter/material.dart';
import 'package:marsa_delivery/utill/app_color.dart';

class EditTextWithNum extends StatelessWidget{
  String hint  ;
  String error  ;
  IconData? image   ;
  TextEditingController edTxtController  ;
 Color edTextColor  ;
 Function? onTap ;
 String? imageStr ;

  EditTextWithNum({required this.hint,this.onTap ,   required this.edTextColor , required  this.error, this.image,required this.edTxtController ,this.imageStr, Key? key}): super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return  Padding(padding: const EdgeInsets.only(bottom: 8.0 , left: 30.0  , right: 30.0 , top: 30.0) ,
  child:TextField(controller:  edTxtController,enabled: true,keyboardType:TextInputType.number,
          onTap:()=> onTap!() ,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.logRed),
            ),

            hintText: hint ,
          //  hintStyle: TextStyle(color: AppColors.greyDark),

           // prefixIcon:Icon(image ,color: AppColors.logRed,),
            prefixIconConstraints:  BoxConstraints(
                minHeight: 24,
                minWidth: 24
            ),
            prefixIcon:image== null?   Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Image(
                  image: AssetImage(
                   imageStr!,
                  ),
                  height: 20,
                  width: 20,
                ),
              )
                
                :Icon(image ,color: AppColors.logRed,),
          )  ,
      ),)

    ;  }
}