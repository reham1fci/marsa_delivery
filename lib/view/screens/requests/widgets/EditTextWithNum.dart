import 'package:flutter/material.dart';
import 'package:marsa_delivery/utill/app_color.dart';

class EditTextWithNum extends StatelessWidget{
  TextEditingController edTxtController  ;
 Function? onTap ;
 String? imageStr ;
 Color?color ;

  EditTextWithNum({this.onTap ,required this.edTxtController ,this.imageStr,this.color, Key? key}): super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return  Padding(padding: const EdgeInsets.only(bottom: 8.0 , left: 30.0  , right: 30.0 , top: 8.0) ,
  child:TextField(controller:  edTxtController,enabled: true,
          onTap:()=> onTap!() ,onChanged:(S)=> onTap!() ,keyboardType:TextInputType.number,

          decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.only(right:15 ,left: 15.0),
              filled: true,
              fillColor: AppColors.lightGrey,
              border: OutlineInputBorder(

                borderRadius: BorderRadius.circular(25),
              ),
    enabledBorder: const OutlineInputBorder(
    // width: 0.0 produces a thin "hairline" border
    borderSide: const BorderSide(color: AppColors.lightGrey, width: 0.0),
    ),



          //  hintStyle: TextStyle(color: AppColors.greyDark),

           // prefixIcon:Icon(image ,color: AppColors.logRed,),
            suffixIconConstraints:  BoxConstraints(
                minHeight: 24,
                minWidth: 24
            ),
              suffixIcon:  Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Image(
                  color:color ,
                  image: AssetImage(
                   imageStr!,
                  ),
                  height: 20,
                  width: 20,
                ),
              )

          )  ,
      ),)

    ;  }
}