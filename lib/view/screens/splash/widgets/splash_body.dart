
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_images.dart';
import 'package:marsa_delivery/utill/app_strings.dart';
import 'package:marsa_delivery/view/screens/login/login_view.dart';
import 'package:marsa_delivery/view/screens/main_screen/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashBody extends StatefulWidget{
  const SplashBody({Key? key}) : super(key: key);

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  late SharedPreferences sharedPrefs ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        const Duration(seconds: 3),
            () => checkUser()
    );
  }
  checkUser() async {
    sharedPrefs = await SharedPreferences.getInstance();

    if(sharedPrefs.containsKey("user")){

      //  user = User.fromJsonShared(json.decode(sharedPrefs.getString("user") )) ;

      Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => Main())) ;


      // api.login( onError:  onError, onLogin:
      //  onLogin, password: user.password , username: user.userName ) ;
    }
    else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>    Login()),
      ) ; }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold( backgroundColor: Colors.black,
    body:AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.black,

        ),child:Center( child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
    const   Spacer(),

    Image.asset(Images.logo,
    fit: BoxFit.cover,
    repeat: ImageRepeat.noRepeat,
    ),
    const   Spacer(),
      Text( getTranslated(Strings.appName, context)??"" ,style:   const  TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 30.0 ,
    color: AppColors.logRed
    ),),
    //  padding:const EdgeInsets.all(100),) ,
    const   Spacer(),

    const  CircularProgressIndicator(color: AppColors.logRed,),
    const   Spacer(),


    ]),
    ) ));
  }
}