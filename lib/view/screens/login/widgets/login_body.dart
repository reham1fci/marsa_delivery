
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/model/client.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/utill/app_images.dart';
import 'package:marsa_delivery/view/base/alert_dialog.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';
import 'package:marsa_delivery/view/screens/login/forget_password.dart';
import 'package:marsa_delivery/view/screens/login/signup.dart';
import 'package:marsa_delivery/view/base/EditText.dart';
import 'package:marsa_delivery/view/screens/main_screen/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginBody extends StatefulWidget{
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
bool isLoading = false  ;
TextEditingController userNameEd  =  TextEditingController()  ;
TextEditingController passEd  =  TextEditingController()  ;
Api api  = Api() ;
 late SharedPreferences sharedPrefs ;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     backgroundColor: AppColors.colorPrimary,

     body: Center(

         child:   Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
            //  Spacer() ,
             isLoading? const Center(
               child: CircularProgressIndicator(color: AppColors.logRed,),
             ): const SizedBox(),
             Padding(padding: const EdgeInsets.only(bottom: 20.0) , child: Image.asset(Images.logo  , height: 200, )),
            // Spacer() ,
             EditText(hint: getTranslated("user_name", context)??"", error: "", image:Icons.person, edTxtController: userNameEd , edTextColor: Colors.white),
             EditText(hint: getTranslated("password", context)??"", error: "", image: Icons.lock, edTxtController: passEd , edTextColor: Colors.white),
           //   Spacer() ,
             CustomBtn(buttonNm: getTranslated("login", context)??"", onClick: onLoginBtn ,  backBtn:AppColors.logRed, txtColor: AppColors.white,),
  Row(children: [
    Spacer(),
    TextButton(onPressed: (){
      Navigator.push( context,
          MaterialPageRoute(builder: (context) => ForgetPassword())) ;
    }, child: Text(getTranslated('forget_pass', context)??"" , style:  TextStyle(color:AppColors.white), )) ,
    Spacer(),

    TextButton(onPressed: (){
      Navigator.push( context,
          MaterialPageRoute(builder: (context) => Signup())) ;
    }, child: Text(getTranslated('signup', context)??"" ,  style:  TextStyle(color:AppColors.white))) ,
    Spacer()

  ],)

           ],)),
   );
  }
  onLoginBtn(){
    api.checkInternet(onConnect: () {
      setState(() {
        String userName  = userNameEd.text ;
        String password  = passEd.text ;
        setState(() {
          bool isValidate =   loginValidation(userName ,password)  ;
          if(isValidate){
            isLoading = true  ;
            User user  = User.login(userName, password) ;
            api.request(url: Constants.LOGIN_URL, map:user.toMap()  , onError:  (String errorMsg
                ){
              CustomDialog.dialog(context: context, title: "", message: errorMsg, isCancelBtn: false) ;
            }

                , onSuccess:onLoginSuccess
            );

          }
          else{
            CustomDialog.dialog(context: context, title: "", message: getTranslated("fill_data", context)??"", isCancelBtn: false) ;

                 }
        });

      });
    },notConnect: (){
      CustomDialog.dialog(context: context  , title:getTranslated("error" , context)??"error"
          , isCancelBtn: false ,message:getTranslated("no_internet" , context)??"No Internet Connection"  , onOkClick: (){} ) ;

    });

  }
void onLoginSuccess (var  jsonObj ) {
  var jsonStr = json.decode(jsonObj);
  setState(() {
    isLoading = false ;
  });
  String  msg  = jsonStr['msg']  ;
  print(msg) ;
  if(msg=="succes"){
    var  userObj  = jsonStr['user_info']  ;
print(userObj)  ;
     User user =User.fromJson(userObj, passEd.text) ;
  setState(() {
    print(user.toString());
    saveUserData(user);
    Navigator.pushReplacement( context,
        MaterialPageRoute(builder: (context) => Main())) ;
  });
  }
  else{

    CustomDialog.dialog(context: context, title: getTranslated("error" , context)??"error", message: msg, isCancelBtn: false) ;

  }
}
bool loginValidation (String name  , String password){
  if(name.isEmpty) {
    return false  ;
  }
  else if(password.isEmpty){
    return false  ;
  }
  else{
    return true ;
  }

}
void saveUserData (User user )async {
  sharedPrefs = await SharedPreferences.getInstance();
  // Setting setting  = Setting(currency:"ريال"  , discountIsPer: true , priceWTax:false , taxPer:15.0 ) ;
  //sharedPrefs.setString("setting", json.encode(setting.toJsonShared()) );
  sharedPrefs.setString("user", json.encode(user.toJson()) );
}



}