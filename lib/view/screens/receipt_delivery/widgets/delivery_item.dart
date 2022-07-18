
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/Shipment.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/model/point_sale_client.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/view/base/alert_dialog.dart';
import 'package:marsa_delivery/view/base/map_show.dart';
import 'package:marsa_delivery/view/base/reason_dialog.dart';
import 'package:marsa_delivery/view/screens/PlacePicker/place_picker.dart';
import 'package:marsa_delivery/view/screens/receipt_delivery/customer_details.dart';
import 'package:marsa_delivery/view/screens/receipt_delivery/widgets/delivery_methods.dart';
import 'package:popup_menu/popup_menu.dart' as popup;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:url_launcher/url_launcher.dart';


class DeliveryItem extends StatefulWidget{
  int index ;
  List<Shipment>list  = [] ;
  Function? onRefresh ;
   User mUser  ;
  DeliveryItem ({required this.index , required this.list , this.onRefresh  ,required this.mUser,Key? key}) : super(key: key);
  @override
  State<DeliveryItem> createState() => _DeliveryItemState();
}

class _DeliveryItemState extends State<DeliveryItem> {
  Api api = Api()  ;
 late Shipment item  ;
 String barcode=""  ;
  bool loading  = false  ;
    User? user  ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     user  = widget.mUser  ;
  }



  @override
  Widget build(BuildContext context) {
    item   =  widget.list [widget.index]  ;

    // TODO: implement build
    return   GestureDetector(
onLongPressStart: (LongPressStartDetails details){
  showPopupMenu(item, details.globalPosition) ;
},
      child: Padding(padding:const EdgeInsets.all(5.0) ,child:Card(
        color: AppColors.white,
        //RoundedRectangleBorder, BeveledRectangleBorder, StadiumBorder
        shape:  const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10.0),
              top: Radius.circular(10.0)),
        ) ,
        child:Container(
            padding: const EdgeInsets.all(8),
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         Padding(padding: const EdgeInsets.all(5.0) ,child:  Row( children: [TextButton(onPressed: onPressCustomerName, child:Text(item.customerNm! ,style: TextStyle(fontSize: 17,color: Colors.black),) ),Spacer() ,Text(item.distanceBetween!.toStringAsFixed(2) +" "+ getTranslated("km", context)!,style: TextStyle(color: AppColors.logRed),)] ) ),
          Padding(padding: const EdgeInsets.all(5.0) ,child:      Row(
          children: [
          TextButton.icon(icon:  Icon(Icons.phone_android ,color: AppColors.logRed,) ,label: Text(item.customerMobile!,style: TextStyle(color: Colors.black)) ,onPressed: (){
            launch(('tel://${item.customerMobile}'));

          },)
            , Spacer()   ,
            TextButton.icon(icon:Icon(Icons.pin_drop ,color: AppColors.logRed),label: Text(getTranslated("client_loc", context)??"",style: TextStyle(color: Colors.black),),onPressed: (){
              if(item.lat!.isNotEmpty&& item.lng!.isNotEmpty){
                double lat  = double.parse(item.lat!) ;
                double lng  = double.parse(item.lng!) ;
                MapsLauncher.launchCoordinates(
                    lat, lng, getTranslated("client_loc", context)).then((value) {
                     print("mab") ;
                      widget.onRefresh!();
                });
              }
              else{
                Navigator.push( context,
                    MaterialPageRoute(builder: (context) => PlacePicker())).then((value ){
                  setState(() {
                    item.lat =   value["lat"].toString()  ;
                    item.lng =   value["lng"].toString()  ;
                    addCustomerLocation(item) ;
                    // save customer location  ;
                  });
                } );
              }
            },)],) ) ,
             Row(children: [
               Padding(padding: const EdgeInsets.all(5.0) , child: Text(item.productName!)),
              Spacer() ,
              Text('${getTranslated("qty", context)??""}  :' , style: TextStyle(color: AppColors.logRed),),   Padding(padding: const EdgeInsets.all(5.0) ,child:Text(item.qty!)),
               Spacer() ,
               Padding(padding: const EdgeInsets.all(5.0) ,child:Text(item.date!))
             ],)
            ],)),

      )) ,
      onTap: (){

      },
    )   ;
  }
onPressCustomerName(){
  Navigator.push( context,
      MaterialPageRoute(builder: (context) => CustomerDetails(item.customerID!, item.date!))) ;
}
  showPopupMenu(Shipment item , Offset offset) {
    popup.PopupMenu menu = popup.PopupMenu(
      backgroundColor: AppColors.logRed,
      // lineColor: Colors.tealAccent,
      maxColumn: 2,

      context: context,
      items: [
      popup. MenuItem(title: getTranslated("delivery_done", context), image: Icon(Icons.done, color: Colors.black , )),
      popup.  MenuItem(title:  getTranslated("not_delivered", context), image: Icon(Icons.phonelink_erase_rounded, color: Colors.black,)),
      ],
      onClickMenu: (popup.MenuItemProvider menuItem){
        if(menuItem.menuTitle ==  getTranslated("delivery_done", context) ) {
        //  scan()  ;
       onDeliveryDone() ;
          
        }
        else{
onDeliveryNotDone();
         // onDeleteClick(item) ;
        }

      },
    );
    menu.show(rect: Rect.fromPoints(offset, offset));
  }
  Future scan() async {
    try {
      ScanResult qrScanResult = await BarcodeScanner.scan();
      String barcode = qrScanResult.rawContent;
      setState(()  {
        loading  = true ;
        this.barcode = barcode;
        print("barcode12345") ;
        print("barcode12345"+this.barcode) ;
      //  _searchQueryController.text  = barcode  ;
        setState(() {
          String s  = this.barcode.replaceAll(" ", "");
        //  searchItemByBarcode(s) ;
deliveryByQr(s)       ;

        });

      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
   onDeliveryDoneSuccess(String jsonObj) {
     var jsonStr = json.decode(jsonObj);
     String  msg  = jsonStr['msg']  ;
     print(msg) ;
     if(msg=="تمت عملية التسليم بنجاح") {
       // Navigator.of(context).pop();
       CustomDialog.dialog(context: context,
           title: "",
           message: msg,
           onOkClick: (){widget.onRefresh!() ;},
           isCancelBtn: false);
     //  widget.onRefresh!() ;

     }
     else{
       CustomDialog.dialog(context: context,
           title: "",
           message: msg,
           isCancelBtn: false);

     }

   }
   onError( String err){
     Navigator.of(context).pop();
     CustomDialog.dialog(context: context,
         title: "",
         message: err,
         isCancelBtn: false);

   }
    deliveryByQr(String qrCode ){
      Navigator.of(context).pop() ;

      int intBarcode = int.parse(qrCode) ;
      int intCustomId = int.parse(item.customerID!) ;
      if(intBarcode == intCustomId) {
        Map m = item.deliveryDoneMap(user!.userId! ,user!.lat! ,user!.lng!);
        api.request(url: Constants.Deliovery_Done_URL, map: m, onSuccess:onDeliveryDoneSuccess , onError: onError
        );

      }
      else{
        CustomDialog.dialog(context: context,
            title: "",
            message: getTranslated("qr_err", context)??"",
            isCancelBtn: false);
      }

      }
     deliveryByDistance  (){
       Navigator.of(context).pop() ;

       if(item.distanceBetween! < 1) {
      Map m = item.deliveryDoneMap(user!.userId! ,user!.lat! ,user!.lng!);
      api.request(url: Constants.Deliovery_Done_URL, map: m, onSuccess:onDeliveryDoneSuccess , onError: onError
      );
    }
     else{
      CustomDialog.dialog(context: context,
          title: "",
          message: getTranslated("out_location", context)??"",
          isCancelBtn: false);
    }

     }

   onDeliveryDone(){
 /*   print("custom-id${item.customerID}") ;
    print("custom-id${qrCode}") ;
    int intBarcode = int.parse(qrCode) ;
    int intCustomId = int.parse(item.customerID!) ;
     if(intBarcode == intCustomId) {
     if(item.lat!.isNotEmpty && item.lng!.isNotEmpty) {
       Map m = item.deliveryDoneMap(user!.userId! ,user!.lat! ,user!.lng!);
       api.request(url: Constants.Deliovery_Done_URL, map: m, onSuccess:onDeliveryDoneSuccess , onError: onError
       );
     }
      else{
       CustomDialog.dialog(context: context,
           title: "",
           message: getTranslated("add_location", context)??"",
           isCancelBtn: false);
         // dialog mok3 el32amel
     }
     }
     else{
       CustomDialog.dialog(context: context,
           title: "",
           message: getTranslated("qr_err", context)??"",
           isCancelBtn: false);
     }*/
     if(item.lat!.isNotEmpty && item.lng!.isNotEmpty) {

       showDialog<void>(
           context: context,
           barrierDismissible: false, // user must tap button!
           builder: (BuildContext context) {
             return  DeliveryMethods(onDistanceClick: deliveryByDistance, onQrClick:scan ,) ;


     });
     }
     else{
       CustomDialog.dialog(context: context,
           title: "",
           message: getTranslated("add_location", context)??"",
           isCancelBtn: false);
       // dialog mok3 el32amel
     }
     }

   onDeliveryNotDone(){
     TextEditingController reasonEd  =  TextEditingController()  ;
      String err ="" ;
     showDialog<void>(
         context: context,
         barrierDismissible: false, // user must tap button!
         builder: (BuildContext context) {
           return ReasonDialog(edTxtController: reasonEd , err: err, onCancelClick: (){
             Navigator.of(context).pop() ;
           } ,


             onOKClick:(){

            if(reasonEd.text.isEmpty) {
              setState(() {
                err  = getTranslated("write_reason", context)??"" ;
              });
            }
             else{
              Map m = item.deliveryNotDoneMap(user!.userId!, reasonEd.text ,user!.lat! , user!.lng!);
              api.request(url: Constants.Deliovery_NOT_Done_URL, map: m,
                  onSuccess:onNotDeliverySuccess ,
                  onError: onError) ;
            }
           } ,);
     });

   }
   onNotDeliverySuccess (var jsonObj){
     var jsonStr = json.decode(jsonObj);
     String  msg  = jsonStr['msg']  ;
     print(msg) ;
     if(msg=="تمت العمليه بنجاح") {
       Navigator.of(context).pop();
       CustomDialog.dialog(context: context,
           title: "",
           message: msg,
           onOkClick:(){
             widget.onRefresh!() ;
           } ,
           isCancelBtn: false);

     }
     else{
       CustomDialog.dialog(context: context,
           title: "",
           message: msg,
           isCancelBtn: false);

     }
     print(jsonObj) ;
   }

  addCustomerLocation(Shipment c ){
    Map m = <String,dynamic>{} ;
    m["customer_id"] = c.customerID  ;
    m["lat"] = c.lat  ;
    m["lng"] = c.lng  ;
    api.request(url: Constants.ADD_CustomerLoc, map: m, onSuccess: onSuccessAddedLocation, onError: onErr) ;
  }
  onSuccessAddedLocation( var jsonStr ){
    var jsonObj = json.decode(jsonStr);
    print(jsonObj) ;
    String  msg  = jsonStr['msg']  ;
    if(msg== "تمت عملية اضافة موقع العميل بنجاح") {
      CustomDialog.dialog(context: context, title: "", message: msg, isCancelBtn: false,onOkClick: (){
        widget.onRefresh!() ;
      }) ;

    }
    else{
      CustomDialog.dialog(context: context, title: getTranslated("error" , context)??"error", message: msg, isCancelBtn: false) ;

    }
  }
  onErr(String err){
    CustomDialog.dialog(context: context, title: "", message: getTranslated("error" , context)??"error", isCancelBtn: false) ;

  }
}
