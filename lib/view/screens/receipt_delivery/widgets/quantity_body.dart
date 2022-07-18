
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/Shipment.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/view/base/dropdown_btn.dart';
import 'package:marsa_delivery/view/base/no_thing_to_show.dart';
import 'package:marsa_delivery/view/screens/receipt_delivery/widgets/quantity_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
class QuantityBody extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return _State();
  }

}

class _State extends State<QuantityBody> {
  late List<Shipment> shipmentList  =[];
  static List<Shipment> filterList  =[];
  static List<String> datesList  =[];
 bool loading  = true  ;
  User? user  ;
 Api api  = Api() ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData()  ;
  }
  Future <void> getUserData() async {
    shipmentList= [] ;
    datesList=[] ;
    filterList =  shipmentList ;
    SharedPreferences  shared = await SharedPreferences.getInstance();
    user = User.fromJsonShared(json.decode(shared.getString("user")!));
    Map m  = {"delivery_id":user?.userId} ;
    await api.request(url: Constants.SHOW_QTY, map: m, onSuccess: onGetRequest, onError: (err){

    });

  }
  onGetRequest( var jsonObj) {
    setState(() {
      loading = false;
    });
    print(jsonObj);
    List<dynamic> list = json.decode(jsonObj);
    print(list);
    datesList.add(getTranslated("all", context)??"")  ;

    for (int i = 0; i < list.length; i++) {
      print(list[i]);
      Shipment ship = Shipment.fromJsonQ(list[i]);
      setState(() {
        if(datesList.contains(ship.date)){
        }
        else{
          datesList.add(ship.date!) ;
        }
        shipmentList.add(ship);
      });
    }
  }

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
           backgroundColor: AppColors.appBar,title:Text( getTranslated("qtys", context)??"",style: const TextStyle(color: AppColors.logRed),) ) ,

       body:   loading ? Center(child:CircularProgressIndicator(color: AppColors.logRed,)): shipmentList.isNotEmpty ?
        Container( height :double.infinity,child:   Column(children: [
        Padding(padding: EdgeInsets.all(10)    ,
            child:DropDownBtn(items:datesList  , onChanged:(value){
              setState(() {
                if(value == getTranslated("all", context)){
                  filterList  = shipmentList  ;
                }
                else{
                  filterList =
                      shipmentList
                          .where((u) =>
                      (u.date!.toLowerCase().contains(
                          value.toLowerCase())
                      ))
                          .toList();
                  print(filterList.toString());}
              });
            }) ),

       Expanded(child:ListView.builder(
          itemBuilder: (context  , index ){
         return QtyItem(ship: shipmentList[index] ,onTap:  (){

         },) ;
          } ,itemCount:  shipmentList.length , ))]))
            :const NoThingToShow() ,

    );
  }

}