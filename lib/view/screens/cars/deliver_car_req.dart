
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/model/car.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/utill/app_images.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';
import 'package:marsa_delivery/view/screens/cars/widgets/employee_search.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DeliverCarReq extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return _State();
  }

}
class _State extends State<DeliverCarReq> {
  Car? car ;
  bool loading= true;
User? user  ;
  Api api = Api() ;
  bool enableBtn = false  ;
  User? selectedEmployee ;
  String employeeName  = "" ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserData();
  }
  getUserData() async {
    SharedPreferences  shared = await SharedPreferences.getInstance();
    user = User.fromJsonShared(json.decode(shared.getString("user")!));
    getCarData() ;

  }
  getCarData() async {
    Map m  = {"driver_id":user!.userId} ;
    print(m) ;
    await api.request(url:Constants.SHOWCARS, map: m, onSuccess: onSuccess, onError: onError) ;

  }

  onSuccess(var jsonStr){
    var   jsonObj = json.decode(jsonStr);
    print(jsonObj) ;
setState(() {
  loading= false ;
  car = Car.fromJson(jsonObj);
  print(car) ;

});

  }

  onError(String err){
    print(err) ;
  }
  @override
  Widget build(BuildContext context) {
    final _screen =  MediaQuery.of(context).size;

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
        iconTheme:  const IconThemeData(color: AppColors.appBarIcon),
    centerTitle: true,
    systemOverlayStyle:const SystemUiOverlayStyle(
    // Status bar color
    statusBarColor: AppColors.statusAppBar,),
    backgroundColor: AppColors.appBar,title:Text( getTranslated("deliver_car_req", context)??"",style: const TextStyle(color: AppColors.logRed),) ) ,
    body:
    loading? const Center(
      child: CircularProgressIndicator(color: AppColors.logRed,),
    )  :Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     Padding(padding: EdgeInsets.all(40),child: Image.network(
        car!.carIcon!,
        height: 150,
        fit: BoxFit.cover, // Fixes border issues
      )),
    Padding(padding: EdgeInsets.only(left: 40 , right: 40),child: Text('${getTranslated("car_plate", context)??""} :${car!.plateNum}')) ,
  /*    Row(
        children: [
      Container(
        width: _screen.width * 0.50,
     child:  Column(
            children: [

          ],) ),
          Container(
        width: _screen.width * 0.50,
     child:  Column(
            children: [

            ],) ),

        ],
      ),*/
       Row(
        children: [
          Container(
              width: _screen.width * 0.50,
              child:  Column(
                children: [
                  TextButton.icon(onPressed: null, icon:  ImageIcon(
                    AssetImage(Images.carStruct),
                    color: AppColors.logRed,
                  ), label:Text('${getTranslated("struc_num", context)??""} : ${car!.structNum!}') ) ,
                  TextButton.icon(onPressed: null, icon:  ImageIcon(
                    AssetImage(Images.carModel),
                    color: AppColors.logRed,
                  ), label:Text('${getTranslated("model", context)??""} : ${car!.carModel!}') ) ,
                ],) ),
          Container(
              width: _screen.width * 0.50,
              child:  Column(
                children: [
                  TextButton.icon(onPressed: null, icon:  ImageIcon(
                    AssetImage(Images.carNm),
                    color: AppColors.logRed,
                  ), label:Text('${getTranslated("name", context)??""} : ${car!.carName!}') ) ,

                  TextButton.icon(onPressed: null, icon:  ImageIcon(
                    AssetImage(Images.carType),
                    color: AppColors.logRed,
                  ), label:Text('${getTranslated("car_type", context)??""} : ${car!.carType!}') ) ,

                ],) ),

        ],
      ) ,
    GestureDetector(child:  Row(
        children: [
          Container(
              width: _screen.width * 0.50,

            child:   TextButton(child: Text(employeeName.isEmpty?getTranslated("emp_name", context)??"":employeeName,textAlign: TextAlign.start,),onPressed: null,) ,

             ),
          Container(
              width: _screen.width * 0.50,
              child:   Icon(Icons.arrow_drop_down_sharp)
          ),

        ],
      ),onTap: (){
      showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return EmployeeSearch(onClick: (User u){
              setState(() {
                employeeName = u.name!  ;
                selectedEmployee =u  ;
              });

            },);
          });
    },),
Spacer() ,
      Padding(
          padding:
          const EdgeInsets.only( top: 30),
          child:      CustomBtn(buttonNm: getTranslated("deliver", context)??"", onClick:(){} ,  backBtn:AppColors.logRed, txtColor: AppColors.white,)),
Spacer() ,
    ]));



  }

}