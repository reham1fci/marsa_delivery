//@dart = 2.8

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import 'localization/app_localization.dart';
import 'view/screens/splash/splash_view.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:background_fetch/background_fetch.dart';

// [Android-only] This "Headless Task" is run when the Android app
// is terminated with enableHeadless: true
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  if (isTimeout) {
    // This task has exceeded its allowed running-time.
    // You must stop what you're doing and immediately .finish(taskId)
    print("[BackgroundFetch] Headless task timed-out: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }
  print('[BackgroundFetch] Headless event received.');
  // Do your work here...
  BackgroundFetch.finish(taskId);
}
void main(){
  runApp(
   MyApp()
  );
}
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

String language = "en" ;
SharedPreferences shared ;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLanguage();
  }
  getLanguage() async {
     shared = await SharedPreferences.getInstance();
     print(language) ;
     setState(() {
       language  =  Platform.localeName  ;

       if (shared.containsKey("language")) {
         language = shared.getString("language");
       }
     });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(

        debugShowCheckedModeBanner: false,
        localizationsDelegates: const[
          AppLocalizations.delegate,
          // Built-in localization of basic text for Material widgets
          GlobalMaterialLocalizations.delegate,
          // Built-in localization for text direction LTR/RTL
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales:[
             Locale('en'),
             Locale('ar'),
        ],
        locale: Locale(language),

        home:Splash()
    );
  }
}
