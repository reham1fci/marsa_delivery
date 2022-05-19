
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/utill/app_images.dart';
import 'package:marsa_delivery/view/base/EditText.dart';
import 'package:marsa_delivery/view/base/alert_dialog.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';
import 'package:marsa_delivery/view/screens/custody/widgets/drop_down_list.dart';
import 'package:marsa_delivery/view/screens/custody/widgets/employee_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CustodyDeliveryBody extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return _State();
  }

}
class _State extends State<CustodyDeliveryBody> {
  bool isLoading = false  ;
  static List<User> employee  =[];
  User? selectedEmployee ;

  TextEditingController employeeEd  =  TextEditingController()  ;
  TextEditingController moneyEd  =  TextEditingController()  ;
  TextEditingController detailsEd  =  TextEditingController()  ;
  Api api = Api() ;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();

   }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          iconTheme:  const IconThemeData(color: AppColors.appBarIcon),
          systemOverlayStyle:const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: AppColors.statusAppBar,),
          backgroundColor: AppColors.appBar,title:Text( getTranslated ("add_custody", context)??"",style: const TextStyle(color: AppColors.logRed),) ),

      body: Center(

          child:    SingleChildScrollView(child:   Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Spacer() ,
              isLoading? const Center(
                child: CircularProgressIndicator(),
              ): const SizedBox(),

              // Spacer() ,
           /* employee.length==0?  CircularProgressIndicator(): DropDownList(employes: employee,onChange: (user){
                selectedEmployee = user ;
                print(user.name);
              },) */
              EditText(hint: getTranslated("emp_name", context)??"", error: "", image:  Icons.person, edTxtController: employeeEd , edTextColor: Colors.white , onTap: () {
                showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return EmployeeList(onClick: (User u){
                        setState(() {
                          employeeEd.text = u.name!  ;
                          selectedEmployee =u  ;
                        });

                      },);
                    });
              }),
              EditText(hint: getTranslated("money_amount", context)??"", error: "", imageStr: Images.money, edTxtController: moneyEd , edTextColor: Colors.white),
              EditText(hint: getTranslated("details", context)??"", error: "", image: Icons.add_box, edTxtController: detailsEd , edTextColor: Colors.white),
              //   Spacer() ,
              Padding(
                  padding:
                  const EdgeInsets.only( top: 30),
                  child:      CustomBtn(buttonNm: getTranslated("add_custody", context)??"", onClick:addCustody
                  ,  backBtn:AppColors.logRed, txtColor: AppColors.white,)),

            ],))),
    ) ;
  }
  addCustody() async {
    SharedPreferences  shared = await SharedPreferences.getInstance();
  User  user = User.fromJsonShared(json.decode(shared.getString("user")!));
   setState(() {
     String name = employeeEd.text ;
     String money = moneyEd.text ;
     String details = detailsEd.text ;
     if(validation(name, money, details)){
       isLoading = true ;
       Map m  = {"driver_id":user.userId,"employ_id":selectedEmployee!.userId , "amount":money ,"details":details} ;
       api.request(url: Constants.addCustody, map: m, onSuccess: onSuccess, onError: (err){
         print(err);
       }) ;

     }else{
       CustomDialog.dialog(context: context, title: "", message: getTranslated("fill_data", context)??"", isCancelBtn: false) ;

     }

   });
  }
  onSuccess(var jsonObj){
    var jsonStr = json.decode(jsonObj);
    setState(() {
      isLoading = false ;
    });
    print(jsonStr);
    String  msg  = jsonStr['msg']  ;
    print(msg) ;
    if(msg=="تمت عملية الارسال بنجاح"){
      CustomDialog.dialog(context: context, title: "", message: msg, isCancelBtn: false ,onOkClick: (){
        Navigator.of(context).pop();

      }) ;

    }
    else{
      CustomDialog.dialog(context: context, title: getTranslated("error" , context)??"error", message: msg, isCancelBtn: false) ;

    }

  }
  bool validation (String name  , String money , String details){
    if(name.isEmpty) {
      return false  ;
    }
    else if(money.isEmpty){
      return false  ;
    } else if(details.isEmpty){
      return false  ;
    }
    else{
      return true ;
    }

  }
}