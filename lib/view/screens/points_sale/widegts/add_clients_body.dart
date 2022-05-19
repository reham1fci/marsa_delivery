import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/model/point_sale_client.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/utill/app_images.dart';
import 'package:marsa_delivery/view/base/EditText.dart';
import 'package:marsa_delivery/view/base/add_location_btn.dart';
import 'package:marsa_delivery/view/base/alert_dialog.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';
import 'package:intl/intl.dart';
import 'package:marsa_delivery/view/screens/PlacePicker/place_picker.dart';
import 'package:marsa_delivery/view/screens/search_location.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AddClientsBody extends StatefulWidget{
   AddClientsBody({Key? key}) : super(key: key);

  @override
  State<AddClientsBody> createState() => _AddClientsBodyState();
}

class _AddClientsBodyState extends State<AddClientsBody> {
   bool isLoading = false  ;
   String? lat  ;
    String? lng  ;
    String address= "" ;
   Api api = Api() ;
   String googleApikey = "GOOGLE_MAP_API_KEY";
   GoogleMapController? mapController; //contrller for Google map
   CameraPosition? cameraPosition;
   LatLng startLocation = LatLng(27.6602292, 85.308027);
   String location = "Location Name:";
   // late LocationResult _pickedLocation;
   //PickResult? selectedPlace;
//   static final kInitialPosition = LatLng(-33.8567844, 151.213108);

   late User user ;
  late SharedPreferences shared ;
   TextEditingController customNumEd  =  TextEditingController()  ;
   TextEditingController customName  =  TextEditingController()  ;
  TextEditingController locationEd =  TextEditingController()  ;

  TextEditingController customPhone  =  TextEditingController()  ;
   Future <void> getUserData() async {
     shared = await SharedPreferences.getInstance();
     user = User.fromJsonShared(json.decode(shared.getString("user")!));
   }
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData()  ;
  }
     @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      appBar: AppBar(
          iconTheme:  const IconThemeData(color: AppColors.appBarIcon),
          systemOverlayStyle:const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: AppColors.statusAppBar,),
          backgroundColor: AppColors.appBar,title:Text( getTranslated("add_client", context)??"",style: const TextStyle(color: AppColors.logRed),) ) ,

      body:Container(

          child: Center(child: SingleChildScrollView(child:   Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //  Spacer() ,
              isLoading? const Center(
                child: CircularProgressIndicator(),
              ): const SizedBox(),
              // Spacer() ,
              Padding(padding: const EdgeInsets.only(bottom: 20.0) , child: Image.asset(Images.addClient  , height: 120)),

              EditText(hint: getTranslated("custom_name", context)??"", error: "", image: Icons.person, edTxtController: customName , edTextColor: Colors.black87),
              EditText(hint: getTranslated("custom_num", context)??"", error: "", image: Icons.person, edTxtController: customNumEd, edTextColor: Colors.black87),
              EditText(hint: getTranslated("phone", context)??"", error: "", image: Icons.phone, edTxtController: customPhone, edTextColor: Colors.black87),

              EditText(hint: getTranslated("add_location", context)??"", error: "", image: Icons.pin_drop, edTxtController: locationEd, edTextColor: Colors.black87 ,onTap: onDefineLocation,),
             // Text(address) ,
           Padding(padding: EdgeInsets.only(top: 30) ,child: CustomBtn(buttonNm: getTranslated("save", context)??"", onClick: onSaveClick ,  backBtn:AppColors.logRed, txtColor: AppColors.white,),)

            ],)))),
    );    }

   onDefineLocation ()  {

     Navigator.push( context,
         MaterialPageRoute(builder: (context) => PlacePicker())).then((value ){
           setState(() {
           lat =   value["lat"].toString()  ;
           lng =   value["lng"] .toString() ;
           address =   value["address"]  ;
           locationEd.text = address ;

           print(address) ;
 print(lat) ;
 print(lng) ;
           });
     } );
   /*  Navigator.push(
       context,
       MaterialPageRoute(
         builder: (context) => PlacePicker(
           apiKey: "APIKeys.apiKey",   // Put YOUR OWN KEY here.
           onPlacePicked: (result) {
             print(result.formattedAddress);
             Navigator.of(context).pop();
           },
           initialPosition: kInitialPosition,
           useCurrentLocation: true,
           selectInitialPosition: true,

         ),
       ),
     );*/
   }
   onSaveClick(){
     setState(() {
       String num  = customNumEd.text ;
       String name  = customName.text ;
       String phone  = customPhone.text ;
print(lat) ;
       if(validation(num, lat!, lng! , phone , name)){
         PointSaleClient c = PointSaleClient(customerNum: num , lat:lat.toString()  , lng:lng.toString() , phone:phone  , createDate:  Api.getDate('yyyy-MM-dd'), customerName:name  ) ;
         api.request(url: Constants.ADD_POS_CUST_URl, map: c.toMap(user.userId!), onSuccess: onRequestSuccess, onError: (error){}) ;
       }
       else{
         CustomDialog.dialog(context: context, title: "", message: getTranslated("fill_data", context)??"", isCancelBtn: false) ;

       }
     });

   }
   onRequestSuccess(var  jsonStr ) {
     var jsonObj = json.decode(jsonStr);


     String  msg  = jsonObj['msg']  ;
     if(msg == "succes inserting") {
       CustomDialog.dialog(context: context, title: "", message: getTranslated("adding_done", context)??"", isCancelBtn: false ,onOkClick: (){
         Navigator.of(context).pop();

       }) ;

     }
     else{
       CustomDialog.dialog(context: context, title: getTranslated("error" , context)??"error", message: msg, isCancelBtn: false) ;

     }
     print(msg) ;


   }
   bool validation (String num , String lat , String lng , String phone , String name  ) {
     if (num.isEmpty || lat.isEmpty || lng.isEmpty || name.isEmpty || phone.isEmpty ) {
       return false;
     }
     else {
       return true;
     }
   }


}