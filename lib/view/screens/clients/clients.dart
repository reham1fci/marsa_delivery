import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/view/screens/clients/add_client_view.dart';
import 'package:marsa_delivery/view/screens/points_sale/add_clients_view.dart';

class ClientsView extends StatelessWidget{
  const ClientsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          iconTheme:  const IconThemeData(color: AppColors.appBarIcon),
          centerTitle: true,
          systemOverlayStyle:const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: AppColors.statusAppBar,),
          backgroundColor: AppColors.appBar,title:Text( getTranslated("clients", context)??"",style: const TextStyle(color: AppColors.logRed),) ) ,
body: Padding(child:TextButton(child: Text( getTranslated("add_client", context)??"",style: const TextStyle(color: AppColors.logRed ,fontSize: 20),)
  ,onPressed:(){
    Navigator.push( context,
        MaterialPageRoute(builder: (context) => AddClient())) ;
  } ,),
    padding: EdgeInsets.all(20),) ) ;
  }
}