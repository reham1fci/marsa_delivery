
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/Shipment.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/utill/app_strings.dart';
import 'package:marsa_delivery/view/base/alert_dialog.dart';
import 'package:marsa_delivery/view/base/dropdown_btn.dart';
import 'package:marsa_delivery/view/base/dropdown_btn.dart';
import 'package:marsa_delivery/view/base/no_thing_to_show.dart';
import 'package:marsa_delivery/view/screens/points_sale/widegts/client_search_view.dart';
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
  static List<Shipment> shipmentList  =[];
  static List<Shipment> filterList  =[];
  static List<Shipment> selectShipment  =[];
  static List<String> datesList  =[];
  Color cardColor = AppColors.white  ;
  Api api  = Api() ;
   User? user ;
  bool loading  = true  ;
String dropdownvalue  = "اختر التاريخ" ;
  final GestureDetectorKey = GlobalKey<RawGestureDetectorState>();
   bool isSelectAll =false ;
   String status ="" ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  filterList =  shipmentList ;
getUserData()  ;
  }
   Future <void> getUserData() async {
     shipmentList= [] ;
     datesList=[] ;
     filterList =  shipmentList ;

     SharedPreferences  shared = await SharedPreferences.getInstance();
       user = User.fromJsonShared(json.decode(shared.getString("user")!));
       setState(() {
         status  = shared.getString("attend")! ;
       });
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
     datesList.add(getTranslated("all", context)??"")  ;
    for(int i  = 0 ; i<list.length ; i++){
      print(list[i]) ;
      Shipment ship = Shipment.fromJson(list[i]) ;
      setState(() {
         print(ship.date) ;
        if(datesList.contains(ship.date)){
        }
         else{
          datesList.add(ship.date!) ;
        }
        shipmentList.add(ship) ;

      });
print(datesList) ;
    }



   }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return
     Scaffold(
         appBar: AppBar(
             iconTheme:  const IconThemeData(color: AppColors.appBarIcon),
             centerTitle: true,
             systemOverlayStyle:const SystemUiOverlayStyle(
               // Status bar color
               statusBarColor: AppColors.statusAppBar,),
             backgroundColor: AppColors.appBar,title:Text( getTranslated("shipment_receipt", context)??"",style: const TextStyle(color: AppColors.logRed),) ) ,


         body:loading? const Center(child:CircularProgressIndicator(color: AppColors.logRed,)): shipmentList.isNotEmpty ?
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
    CheckboxListTile(
      title: Text(getTranslated("select_all", context)??""),
      value: isSelectAll,
     checkColor: AppColors.logRed,
activeColor: AppColors.appBarIcon,
      onChanged: (newValue) {
        setState(() {
          isSelectAll = newValue!;
          if(isSelectAll){
            selectAll() ;
          }
          else {
            unSelectAll() ;
          }
        });
      },
      controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
    ),

      Expanded(child: ListView.builder(
     itemBuilder: (context  , index ){
       return
           ShipmentItem(obj:filterList[index]  ,onGet: (var v , bool isAdded){
              if(isAdded){
                selectShipment .add(v)  ;
              }
               else{
                selectShipment .remove(v)  ;

              }
print(selectShipment.toString())  ;

} ,user: user!,onRefresh: getUserData,enableBtn: true,) ;
     } ,itemCount:  filterList.length , ))]))
       :const NoThingToShow() ,
             bottomNavigationBar:
             shipmentList.isNotEmpty ?BottomAppBar(child: TextButton(child: Text(getTranslated("receive", context)??"" , style:  TextStyle(color: Colors.white),),onPressed:onSaveSelectShipment,style: ButtonStyle(backgroundColor:MaterialStateProperty.all(AppColors.logRed,)))):SizedBox()

     );
}
 onSaveSelectShipment (){
    if(status == "active") {
   var map =  <String, dynamic>{};
map["user_id"]  = user?.userId  ;
   List itemsMap = < Map<String, dynamic>>[];
   for (int i = 0; i < selectShipment.length; i++) {

     itemsMap.add(  selectShipment[i].toJson());
   }

   map["list"] = itemsMap ;
api.request2(url: Constants.SELECT_RECEIPT, map: map , onSuccess: onSuccessAdd, onError: (err){print(err);}) ;
}
    else{
      CustomDialog.dialog(context: context, title: getTranslated("error" , context)??"error", message: getTranslated("key", context)??"", isCancelBtn: false) ;

    }

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
selectAll(){
    setState(() {
     // ShipmentItemState().changeCardColor() ;
      for(int i=0  ; i<shipmentList.length;i++){
        shipmentList[i].isSelected=true  ;
        selectShipment.add(shipmentList[i]) ;
      }
      //selectShipment =selectShipment ;
    });


}
  unSelectAll(){
    setState(() {
      // ShipmentItemState().changeCardColor() ;
      for(int i=0  ; i<shipmentList.length;i++){
        shipmentList[i].isSelected=false  ;
      }
      selectShipment= [] ;
      //selectShipment =selectShipment ;
    });


  }
 /*Widget DropDownBtn(){
  return DropdownButton<String>(
   //  value: dropdownvalue,
    isExpanded: true,
    items: datesList.map((String value) {
      return  DropdownMenuItem<String>(
        value: value,
        child:  Text(value),
      );
    }).toList(),
   hint:Text( dropdownvalue),
    onChanged: (string){
      setState(() {
        dropdownvalue = string! ;
        print(string) ;
      });
    },

  );}*/
}