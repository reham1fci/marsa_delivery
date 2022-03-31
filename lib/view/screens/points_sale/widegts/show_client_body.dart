import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/point_sale_client.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/view/base/no_thing_to_show.dart';
import 'package:marsa_delivery/view/screens/points_sale/widegts/list_item.dart';

import 'client_search_view.dart';

class ShowClientsBody extends StatefulWidget{
   ShowClientsBody({Key? key}) : super(key: key);


  State<ShowClientsBody> createState() => ShowClientsBodyState();


  }

  class ShowClientsBodyState extends State<ShowClientsBody> {
  static List<PointSaleClient> clientsList  = [] ;
  static List<PointSaleClient> filterList  = [] ;
  Api api  = Api();
  @override
  void initState() {
  // TODO: implement initState
  super.initState();
  filterList  = clientsList ;
  api.getRequest(url: Constants.SHOW_POS_CUST_URl , onSuccess:onGetRequest, onError: (String err){
    print(err) ;
  }) ;
  }
  onGetRequest( var jsonObj){
    print (jsonObj);
    List<dynamic> list = json.decode(jsonObj);

    for(int i  = 0 ; i<list.length ; i++){
      print(list[i]) ;
      PointSaleClient client = PointSaleClient.fromJson(list[i]) ;
      setState(() {
       clientsList.add(client) ;

      });

    }



  }
  @override
  Widget build(BuildContext context) {
  // TODO: implement build
  return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.colorPrimary,title:Text( getTranslated("clients", context)??"",)) ,

      body:
      clientsList.isNotEmpty ?  Container( height :double.infinity,child:   Column(children: [
  ClientSearchView(onChanged: (string){
  setState(() {
  filterList =
  clientsList
      .where((u) =>
  (u.customerName!
      .toLowerCase()
      .contains(string.toLowerCase()) ||
  u.phone!.toLowerCase().contains(
  string.toLowerCase())))
      .toList();
  });
  },onSearchEnd:(){
  setState(() {
  filterList=clientsList ;

  });
  },onFilter: (){

    },),
 Expanded( child:   ListView.builder(
    shrinkWrap: true,

    itemBuilder: (context, index) {
  return ClientListItem(index:index, list:filterList);
  }, itemCount: filterList.length,) , flex: 1,)

  ],)):const NoThingToShow() ,);

  }
  }
