import 'package:flutter/material.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/view/screens/splash/splash_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class  Language extends StatefulWidget {

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyState? state = context.findAncestorStateOfType<_MyState>();
    state!.changeLanguage(newLocale);
  }
  @override
  _MyState createState() {
    return _MyState();
  }
}

class _MyState extends State<Language>
{
  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
 late Locale _locale;

  bool _value = false;
 late  SharedPreferences shared  ;
  String val = "en";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
getLanguage() ;
  }
  getLanguage() async {
    //await EasyLocalization.ensureInitialized();

    shared = await SharedPreferences.getInstance();
    setState(() {
      if(shared.containsKey("language")) {
        val = shared.getString("language")!;
      }
      else{
      String localLanguage  =  Localizations.localeOf(context).languageCode ;
      print(localLanguage) ;
      if(localLanguage== "en"){
        val = "en";
        shared.setString("language", "en") ;
      }
      else{
        val = "ar";
        shared.setString("language", "ar") ;
      }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: Text(getTranslated("language", context)??"")),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  title: Text("English"),
                  leading: Radio(
                    value: "en",
                    groupValue: val,
                    onChanged: ( value) {
                      setState(() {
                        val = value as String;
                       shared.setString("language", "en") ;
                       // EasyLocalization.of(context)!.setLocale(Locale('en', ''));
                        _restartApp();
                      });
                    },
                    activeColor: AppColors.logRed,
                  ),
                ),
                ListTile(
                  title: Text("العربية"),
                  leading: Radio(
                    value: "ar",
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = value as String;
                       shared.setString("language", "ar") ;
                        _restartApp();
                        // EasyLocalization.of(context)!.setLocale(Locale('ar', ''));

                      });
                    },
                    activeColor: AppColors.logRed,
                  ),
                ),
              ],
            )
        )
    );
  }
  void _restartApp() async {
    await FlutterRestart.restartApp();
  }
}