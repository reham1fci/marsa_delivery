import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/view/base/EditText.dart';

class DistanceDialog extends StatelessWidget{
  Function? onOKClick  ;
  Function? onCancelClick  ;
  TextEditingController? edTxtController  ;
  String? err  ;

  DistanceDialog(
      {this.onOKClick, this.onCancelClick, this.edTxtController, this.err});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title:   Text(getTranslated("daily_kilo_meter", context)??""),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
          //  EditText(hint: getTranslated("add_daily_distance", context)??"", edTextColor: AppColors.black, error: err!, image: Icons.note, edTxtController: edTxtController!)
            Padding(padding: const EdgeInsets.only(bottom: 8.0 , left: 30.0  , right: 30.0 , top: 8.0) ,
              child:   TextField(controller:  edTxtController,keyboardType: TextInputType.number,
                decoration: InputDecoration(

                  hintText: getTranslated("add_daily_distance", context)??"" ,
                  hintStyle: TextStyle(color: AppColors.greyDark),
                  fillColor: Colors.white,
                  filled: false,
                  errorText:  err!,
                  prefixIcon:Icon( Icons.note ,color: AppColors.white,),
                ) , style:  TextStyle(color: AppColors.black) ,
              ),)
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
            child: const  Text("Ok"),
            onPressed: ()=> onOKClick!()
        ),
        TextButton(
            child: const  Text("Cancel"),
            onPressed:()=> onCancelClick!() )

      ],
    );
  }
}