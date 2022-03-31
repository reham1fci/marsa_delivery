
import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_images.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';
import 'package:marsa_delivery/view/screens/login/login_view.dart';
import 'package:marsa_delivery/view/screens/main_screen/main_screen.dart';

import '../../../base/EditText.dart';
class SignupBody extends StatefulWidget{
  const SignupBody({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return SignupBodyState();
  }

}
class SignupBodyState extends State<SignupBody> {
  bool isLoading = false  ;
  TextEditingController userNameEd  =  TextEditingController()  ;
  TextEditingController passEd  =  TextEditingController()  ;
  TextEditingController phoneEd  =  TextEditingController()  ;
  TextEditingController emailEd  =  TextEditingController()  ;
  TextEditingController confirmPassEd  =  TextEditingController()  ;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      body:Center(

          child:    SingleChildScrollView(child:   Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //  Spacer() ,
              isLoading? const Center(
                child: CircularProgressIndicator(),
              ): const SizedBox(),
              Padding(padding: const EdgeInsets.only(bottom: 20.0) , child: Image.asset(Images.logo  , height: 120, )),
              // Spacer() ,
              EditText(hint: getTranslated("user_name", context)??"", error: "", image: Icons.person, edTxtController: userNameEd , edTextColor: Colors.white),
              EditText(hint: getTranslated("email", context)??"", error: "", image: Icons.email, edTxtController: emailEd , edTextColor: Colors.white),
              EditText(hint: getTranslated("phone", context)??"", error: "", image: Icons.phone_android, edTxtController: phoneEd , edTextColor: Colors.white),
              EditText(hint: getTranslated("password", context)??"", error: "", image: Icons.lock, edTxtController: passEd , edTextColor: Colors.white),
              EditText(hint: getTranslated("conf_pass", context)??"", error: "", image:  Icons.lock, edTxtController: confirmPassEd , edTextColor: Colors.white),
              //   Spacer() ,
              CustomBtn(buttonNm: getTranslated("signup", context)??"", onClick: (){
                Navigator.push( context,
                    MaterialPageRoute(builder: (context) => Main())) ;
              } ,  backBtn:AppColors.logRed, txtColor: AppColors.white,),

              TextButton(onPressed: (){
                Navigator.push( context,
                    MaterialPageRoute(builder: (context) => Login())) ;
              }, child: Text('${getTranslated('have_account', context)??""} \n           ${getTranslated('login', context)??""}' ,  style:  TextStyle(color:AppColors.white))) ,

            ],))),
    );  }

}