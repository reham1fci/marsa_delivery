
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/Shipment.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/view/base/alert_dialog.dart';
import 'package:marsa_delivery/view/base/dropdown_btn.dart';
import 'package:marsa_delivery/view/base/no_thing_to_show.dart';
import 'package:marsa_delivery/view/screens/return/widgets/retun_shipment_item.dart';
import 'delivery_ship_item.dart';

class ReturnShipmentBody extends StatefulWidget{
  String driverID  ;

  ReturnShipmentBody(this.driverID);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _State();
  }

}
class _State extends State<ReturnShipmentBody> {
  List<Shipment> shipmentList  =[] ;
  static List<String> datesList  =[];
  static List<Shipment> filterList  =[];

  bool loading  = true  ;
  Api api = Api() ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeliveryReq() ;
  }
  getDeliveryReq() async {
    shipmentList= [] ;
    datesList=[] ;
    filterList =  shipmentList ;
    Map m = {"driver_id" :widget.driverID} ;
    await api.request(url:Constants.RETURNSHIPDET,map:m , onSuccess: onSuccess, onError: onError) ;

  }
  onSuccess(var jsonStr){
    List<dynamic> list = json.decode(jsonStr);
    datesList.add(getTranslated("all", context)??"")  ;

    print(jsonStr);
    for (int i = 0 ; i < list.length ; i ++){
      var   jsonObj=list [i];
      Shipment  c = Shipment.fromJsonReturn(jsonObj);
      setState(() {
        if(datesList.contains(c.date)){
        }
        else{
          datesList.add(c.date!) ;
        }
        shipmentList.add(c);

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
            backgroundColor: AppColors.appBar,title:Text( getTranslated("receive_return", context)??"",style: const TextStyle(color: AppColors.logRed),) ),
        body:  loading? Center (child:CircularProgressIndicator(color: AppColors.logRed,)) :

        Container( height :double.infinity,child:
        Column(children: [
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
          shipmentList.isNotEmpty?  Expanded(child: ListView.builder(
            itemBuilder: (context  , index ){
              return ReturnShipmentItem(onTap: (){onTapShip(index);},ship: filterList[index],);
            } ,itemCount:  filterList.length , ))
              : Expanded(child:NoThingToShow()),],)));


  }
  onTapShip(int index) async {

    Shipment ship  = shipmentList[index] ;
    if(ship.type ==1){
      setState(() {
        loading = true ;
      });
      Map m = {"dis_id" :ship.disId} ;
      await api.request(url:Constants.RECEIPTRETURNSHIP,map:m , onSuccess: onReturnSuccess, onError: onError) ;

    }
    else{
      CustomDialog.dialog(context: context, title: getTranslated("error" , context)??"error", message: "يجب مطالبة المندوب بعمل لم يتم التسليم لهذه الشحنه", isCancelBtn: false) ;

    }
  }

  void onReturnSuccess (var  jsonObj ) {
    var jsonStr = json.decode(jsonObj);
    String  msg  = jsonStr['msg']  ;
    print(msg) ;
    if(msg=="تمت عملية استلام الرجيع بنجاح"){
      getDeliveryReq();
      CustomDialog.dialog(context: context, title:"", message: msg, isCancelBtn: false) ;

    }
    else{

      CustomDialog.dialog(context: context, title: getTranslated("error" , context)??"error", message: msg, isCancelBtn: false) ;

    }
  }
}