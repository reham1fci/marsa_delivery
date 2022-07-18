import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_images.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';

import '../../../base/EditText.dart';

class ForgetPassBody extends StatefulWidget{
  const ForgetPassBody({Key? key}) : super(key: key);

  @override
  State<ForgetPassBody> createState() => _ForgetPassBodyState();
}

class _ForgetPassBodyState extends State<ForgetPassBody> {
bool isLoading= false  ;

  TextEditingController emailEd  =  TextEditingController()  ;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return  Scaffold(
     backgroundColor: AppColors.colorPrimary,
     body: Center(

         child:   Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             //  Spacer() ,
             isLoading? const Center(
               child: CircularProgressIndicator(),
             ): const SizedBox(),
             Padding(padding: const EdgeInsets.only(bottom: 20.0) , child: Image.asset(Images.logo  , height: 120, )),
             // Spacer() ,
             //   Spacer() ,
             EditText(hint: getTranslated("email", context)??"", error: "", image: Icons.email, edTxtController: emailEd , edTextColor: Colors.white,),

             CustomBtn(buttonNm: getTranslated("reset", context)??"", onClick: (){} ,  backBtn:AppColors.logRed, txtColor: AppColors.white,),


           ],)),
   );
  }
}