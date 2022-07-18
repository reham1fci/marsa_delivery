
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/view/base/no_thing_to_show.dart';
import 'package:marsa_delivery/view/screens/return/shipment_return.dart';

import 'delivery_ship_item.dart';
class DeliveryShipmentBody extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return _State();
  }

}
class _State extends State<DeliveryShipmentBody> {
  List<User> deliveryList  =[] ;
  bool loading  = true  ;
  Api api = Api() ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeliveryReq() ;
  }
   getDeliveryReq() async {
     deliveryList  =[] ;
     await api.getRequest(url:Constants.RETURNSHIP, onSuccess: onSuccess, onError: onError) ;

   }
  onSuccess(var jsonStr){
    List<dynamic> list = json.decode(jsonStr);
    print(jsonStr);
    for (int i = 0 ; i < list.length ; i ++){
      var   jsonObj=list [i];
      User  c = User.fromJsonReturn(jsonObj);
      setState(() {
        deliveryList.add(c);

      });
    }
    setState(() {
      loading= false ;
    });


  }

  onError(String err){
    print(err) ;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            iconTheme:  const IconThemeData(color: AppColors.appBarIcon),
            systemOverlayStyle:const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: AppColors.statusAppBar,),
            backgroundColor: AppColors.appBar,title:Text( getTranslated("return", context)??"",style: const TextStyle(color: AppColors.logRed),) ),
        body:  loading? Center (child:CircularProgressIndicator(color: AppColors.logRed,)) :

        Container( height :double.infinity,child:
        Column(children: [
          deliveryList.isNotEmpty?  Expanded(child: ListView.builder(
            itemBuilder: (context  , index ){
              return DeliveryShipItem(onTap: (){

                  Navigator.push( context,
                      MaterialPageRoute(builder: (context) => ShipmentReturn(deliveryList[index].userId))).then((value){
getDeliveryReq() ;
                  });

              },delivery: deliveryList[index],);
            } ,itemCount:  deliveryList.length , ))
              : Expanded(child:NoThingToShow()),],)));


  }


}