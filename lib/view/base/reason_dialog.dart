import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/view/base/EditText.dart';

class ReasonDialog extends StatelessWidget{
Function? onOKClick  ;
Function? onCancelClick  ;
  TextEditingController? edTxtController  ;
   String? err  ;

ReasonDialog(
    {this.onOKClick, this.onCancelClick, this.edTxtController, this.err});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title:   Text(getTranslated("not_delivered", context)??""),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            EditText(hint: getTranslated("write_reason", context)??"", edTextColor: AppColors.black, error: err!, image: Icons.note, edTxtController: edTxtController!)
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