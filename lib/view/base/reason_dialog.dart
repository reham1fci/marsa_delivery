import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/view/base/EditText.dart';

class ReasonDialog extends StatefulWidget{
Function? onOKClick  ;
Function? onCancelClick  ;
  TextEditingController? edTxtController  ;
   String? err  ;


ReasonDialog({
      this.onOKClick, this.onCancelClick, this.edTxtController, this.err});

  @override
  State<ReasonDialog> createState() => _ReasonDialogState();
}

class _ReasonDialogState extends State<ReasonDialog> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title:   Text(getTranslated("not_delivered", context)??""),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            EditText(hint: getTranslated("write_reason", context)??"", edTextColor: AppColors.black, error: widget.err!, image: Icons.note, edTxtController: widget.edTxtController!)
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const  Text("Ok"),
          onPressed: ()=> widget.onOKClick!()
        ),
   TextButton(
          child: const  Text("Cancel"),
          onPressed:()=> widget.onCancelClick!() )

      ],
    );
  }
}