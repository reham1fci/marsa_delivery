
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      body:AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.white,

        ),child:Center(

          child:    SingleChildScrollView(child:   Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Spacer() ,
              isLoading? const Center(
                child: CircularProgressIndicator(),
              ): const SizedBox(),
              Padding(padding: const EdgeInsets.only(bottom: 20.0) , child: Image.asset(Images.sLogo  , height: 120, )),
              Padding(padding: const EdgeInsets.only(left: 30 , right: 30 ,top: 30),child:Align(
                  alignment: Alignment.centerLeft, child: Text(getTranslated("signup_title", context)??"" ,style: TextStyle(color: AppColors.logRed,fontSize: 20),))) ,

              // Spacer() ,
              EditText(hint: getTranslated("user_name", context)??"", error: "", image: Icons.person, edTxtController: userNameEd , edTextColor: Colors.white),
              EditText(hint: getTranslated("email", context)??"", error: "", image: Icons.email, edTxtController: emailEd , edTextColor: Colors.white),
              EditText(hint: getTranslated("phone", context)??"", error: "", image: Icons.phone, edTxtController: phoneEd , edTextColor: Colors.white),
              EditText(hint: getTranslated("password", context)??"", error: "", image: Icons.lock, edTxtController: passEd , edTextColor: Colors.white),
              EditText(hint: getTranslated("conf_pass", context)??"", error: "", image:  Icons.lock, edTxtController: confirmPassEd , edTextColor: Colors.white),
              //   Spacer() ,
        Padding(
          padding:
          const EdgeInsets.only( top: 30),
            child:      CustomBtn(buttonNm: getTranslated("signup_title", context)??"", onClick: (){
                Navigator.push( context,
                    MaterialPageRoute(builder: (context) => Main())) ;
              } ,  backBtn:AppColors.logRed, txtColor: AppColors.white,)),

              Row(children: [
                Spacer(),

                Text(getTranslated("have_acc", context)??"" ) ,
                TextButton(onPressed: (){
                  Navigator.push( context,
                      MaterialPageRoute(builder: (context) => Login())) ;
                }, child: Text(getTranslated('login', context)??"" ,  style:  TextStyle(color:AppColors.logRed ))) ,
                Spacer()

              ],)

            ],))),
      ));  }

}