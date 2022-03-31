
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/Shipment.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/view/base/alert_dialog.dart';
import 'package:marsa_delivery/view/base/no_thing_to_show.dart';
import 'package:marsa_delivery/view/screens/receipt_delivery/widgets/shipment_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReceiptBody extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return _State();
  }

}
class _State extends State<ReceiptBody> {
  late List<Shipment> shipmentList  =[];
  late List<Shipment> selectShipment  =[];
  Color cardColor = AppColors.white  ;
  Api api  = Api() ;
   User? user ;
  bool loading  = true  ;

  final GestureDetectorKey = GlobalKey<RawGestureDetectorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
getUserData()  ;
  }
   Future <void> getUserData() async {
   SharedPreferences  shared = await SharedPreferences.getInstance();
       user = User.fromJsonShared(json.decode(shared.getString("user")!));
   Map m  = {"delivery_id":user?.userId} ;
    await api.request(url: Constants.Receipt_URl, map: m, onSuccess: onGetRequest, onError: (err){

   });

  }
   onGetRequest( var jsonObj){
    print (jsonObj);
     setState(() {
       loading = false;

     });
    List<dynamic> list = json.decode(jsonObj);

    for(int i  = 0 ; i<list.length ; i++){
      print(list[i]) ;
      Shipment ship = Shipment.fromJson(list[i]) ;
      setState(() {
        shipmentList.add(ship) ;

      });

    }



   }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return
     Scaffold(
    appBar: AppBar(backgroundColor: AppColors.colorPrimary,title: Text(getTranslated("shipment_receipt", context)??""),),
  body:loading? const Center(child:CircularProgressIndicator(color: AppColors.logRed,)): shipmentList.isNotEmpty ?    ListView.builder(
     itemBuilder: (context  , index ){
       return
           ShipmentItem(obj:shipmentList[index]  ,onGet: (var v , bool isAdded){
              if(isAdded){
                selectShipment .add(v)  ;
              }
               else{
                selectShipment .remove(v)  ;

              }
print(selectShipment.toString())  ;

} ,) ;
     } ,itemCount:  shipmentList.length , )
       :const NoThingToShow() ,
             bottomNavigationBar:
             shipmentList.isNotEmpty ?BottomAppBar(child: TextButton(child: Text(getTranslated("save", context)??"" , style:  TextStyle(color: Colors.white),),onPressed:onSaveSelectShipment,style: ButtonStyle(backgroundColor:MaterialStateProperty.all(AppColors.logRed,)))):SizedBox()

     );
}
 onSaveSelectShipment (){
   var map =  <String, dynamic>{};
map["user_id"]  = user?.userId  ;
   List itemsMap = < Map<String, dynamic>>[];
   for (int i = 0; i < selectShipment.length; i++) {

     itemsMap.add(  selectShipment[i].toJson());
   }

   map["list"] = itemsMap ;
api.request2(url: Constants.SELECT_RECEIPT, map: map , onSuccess: onSuccessAdd, onError: (err){print(err);}) ;


 }
onSuccessAdd(String jsons ){
  var jsonStr = json.decode(jsons);
  String  msg  = jsonStr['msg']  ;
  print(msg) ;
  if(msg=="تمت عملية الاستلام بنجاح"){
    CustomDialog.dialog(context: context, title: "", message: msg, isCancelBtn: false , onOkClick: (){
      Navigator.of(context).pop() ;

    }) ;

  }
  else{

    CustomDialog.dialog(context: context, title: getTranslated("error" , context)??"error", message: msg, isCancelBtn: false) ;

  }
  print(jsonStr) ;
}

}