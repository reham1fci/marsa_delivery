import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/model/client.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/utill/app_images.dart';
import 'package:marsa_delivery/view/base/add_location_btn.dart';
import 'package:marsa_delivery/view/base/alert_dialog.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';
import 'package:marsa_delivery/view/base/EditText.dart';
import 'package:marsa_delivery/view/screens/PlacePicker/place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddClientBody extends StatefulWidget{
   AddClientBody({Key? key}) : super(key: key);

  @override
  State<AddClientBody> createState() => _AddClientBodyState();
}

class _AddClientBodyState extends State<AddClientBody> {
  bool isLoading = false  ;
   String? lat , lng ;
   String address = "" ;
Api api = Api() ;
  late User user ;
  late SharedPreferences shared ;
  TextEditingController customNumEd  =  TextEditingController()  ;
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
      appBar: AppBar(backgroundColor: AppColors.colorPrimary,title:Text( getTranslated("add_client", context)??"",)) ,

      body:Center(

          child:    SingleChildScrollView(child:   Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //  Spacer() ,
              isLoading? const Center(
                child: CircularProgressIndicator(),
              ): const SizedBox(),
              // Spacer() ,
              Padding(padding: const EdgeInsets.only(bottom: 20.0) , child: Image.asset(Images.addClient  , height: 120,color: Colors.black, )),

              EditText(hint: getTranslated("custom_num", context)??"", error: "", image: Icons.person, edTxtController: customNumEd, edTextColor: Colors.black87),
              AddLocationBtn(onClick:onDefineLocation) ,
              Text(address) ,
              CustomBtn(buttonNm: getTranslated("save", context)??"", onClick:onSaveClick ,  backBtn:AppColors.colorPrimary, txtColor: AppColors.white,),

            ],))),
    );  }
  onDefineLocation ()  {

    Navigator.push( context,
        MaterialPageRoute(builder: (context) => PlacePicker())).then((value ){
      setState(() {
        lat =   value["lat"].toString()  ;
        lng =   value["lng"].toString()  ;
        address =   value["address"]  ;
        print(address) ;
        print(lat) ;
        print(lng) ;
      });
    } );

  }
onSaveClick(){
  setState(() {
   String num  = customNumEd.text ;
  if(validation(num, lat!, lng!)){
    Client c = Client(customerNum: num , lat:lat!  , lng:lng! ) ;
    // Map m  = {"delivery_id":user.userId} ;
    api.request(url: Constants.ADD_CUST_URl, map: c.toMap(user.userId!), onSuccess: onRequestSuccess, onError: (error){}) ;
  }
    else{
    CustomDialog.dialog(context: context, title: "", message: getTranslated("fill_data", context)??"", isCancelBtn: false) ;

  }
  });

}
onRequestSuccess(var  jsonStr ) {
  var jsonObj = json.decode(jsonStr);
  String  msg  = jsonObj['msg']  ;
   if(msg == "تمت اضافة العميل بنجاح") {
     CustomDialog.dialog(context: context, title: "", message: getTranslated("adding_done", context)??"", isCancelBtn: false ,onOkClick: (){
       Navigator.of(context).pop();

     }) ;

   }
   else{
     CustomDialog.dialog(context: context, title: getTranslated("error" , context)??"error", message: msg, isCancelBtn: false) ;

   }
  print(msg) ;

}
bool validation (String num , String lat , String lng  ) {
  if (num.isEmpty || lat.isEmpty  || lng .isEmpty) {
    return false;
  }
  else {
    return true;
  }
}
}