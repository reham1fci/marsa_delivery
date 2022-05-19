import 'package:flutter/material.dart';
import 'package:marsa_delivery/view/screens/main_screen/widgets/main_body.dart';
import 'package:upgrader/upgrader.dart';

class Main extends StatelessWidget{
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appcastURL = 'https://www.marsalogistics.com/new/marsadelivery/appcast.xml';
    final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);

    // TODO: implement build
    return  UpgradeAlert(
      shouldPopScope: () => true,
      countryCode: "sa",
      appcastConfig: cfg,
      debugLogging: true,
      child:MainBody() );
  }
}