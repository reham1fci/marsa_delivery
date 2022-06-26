import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/bank.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/view/base/EditText.dart';

class PaymentWindow extends StatefulWidget{
  Function? onOKClick  ;
  List<Bank>paymentList  = [] ;


  PaymentWindow({
    this.onOKClick, required this.paymentList});

  @override
  State<PaymentWindow> createState() => _State();
}

class _State extends State<PaymentWindow> {
  String? _site ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _site = widget.paymentList[0].bankId;

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title:   Text(getTranslated("payment_way", context)??"" ,style: TextStyle(color: AppColors.logRed),),
      content:Container(height: 200,
          child: Column(
          children: <Widget>[
      ListTile(

      title:  Text(widget.paymentList[0].bankNm!),
      leading: Radio(
        activeColor: AppColors.logRed,
        value: widget.paymentList[0].bankId!,
        groupValue: _site,
        onChanged: (value) {
setState(() {
  _site = value as String? ;
});
        },
      ),
    ),
    ListTile(

      title:  Text(widget.paymentList[1].bankNm!),
    leading: Radio(
      activeColor: AppColors.logRed,

      value:  widget.paymentList[1].bankId!,
    groupValue: _site,
    onChanged: ( value) {
    setState(() {
    _site = value as String?;
    });
    },
    ),
    ),])),
    actions: <Widget>[
        TextButton(
            child: const  Text("Ok",style: TextStyle(color: AppColors.logRed)),
            onPressed: ()=> widget.onOKClick!(_site)
        ),

      ],
    );
  }
}