
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/model/bank.dart';
import 'package:marsa_delivery/model/custody.dart';
import 'package:marsa_delivery/model/custody_type.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/utill/app_images.dart';
import 'package:marsa_delivery/view/base/EditText.dart';
import 'package:marsa_delivery/view/base/EditTextWithNum.dart';
import 'package:marsa_delivery/view/base/alert_dialog.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';
import 'package:marsa_delivery/view/screens/custody/widgets/bank_list.dart';
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
   List<CustodyType> custodyTypes  =[];
   List<Bank> bankList  =[];
  User? selectedEmployee ;
  Bank? selectedBank ;
  CustodyType? selected  ;
  String selectedBankNm ="" ;
  TextEditingController employeeEd  =  TextEditingController()  ;
  TextEditingController moneyEd  =  TextEditingController()  ;
  TextEditingController detailsEd  =  TextEditingController()  ;
  Api api = Api() ;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
createList() ;

   }
   createList()async{
     custodyTypes.add(CustodyType(id: 1  ,title:"كاش"  , value:false )) ;
     custodyTypes.add(CustodyType(id: 2  ,title:"بنك"  , value:false )) ;
     custodyTypes.add(CustodyType(id:3,title:"فاتورة"  , value:false )) ;
     await     api.getRequest(url: Constants.BANKLIST, onSuccess: onGetRequest, onError: (err){

     });
   }
  onGetRequest( var jsonObj) {

    List<dynamic> list = json.decode(jsonObj);
    for (int i = 0; i < list.length; i++) {
      print(list[i]);
      Bank bank = Bank.fromJson(list[i]);
      setState(() {
        bankList.add(bank);
      });
    }
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
            Padding(padding: EdgeInsets.only(left: 30 , right: 30 , top: 8 , bottom: 8) , child:  Column(
                  children: List.generate(
                      custodyTypes.length,
                          (index) =>
            /*  CheckList(checkListItems: custodyTypes, index: index  ,onSelected:(selectedType){
                print(selectedType.toString()) ;
              } ,)*/
                    checkListTile(index)

                  )),),
        Padding(padding: EdgeInsets.only(left: 30 , right: 30 , top: 8 , bottom: 8) , child:Text(selectedBankNm ,style: TextStyle(color: AppColors.logRed),)),
              EditTextWithNum(hint: getTranslated("money_amount", context)??"", error: "", imageStr: Images.money, edTxtController: moneyEd , edTextColor: Colors.white),
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
       Map m  = {"driver_id":user.userId,"employ_id":selectedEmployee!.userId ,
         "amount":money ,"details":details ,"bank_id":selectedBankNm.isNotEmpty?selectedBank!.bankId.toString():selectedBankNm,"type":selected!.id.toString()} ;
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
    else if(money.isEmpty||(double.parse(money)<1)){
      return false  ;
    } else if(details.isEmpty){
      return false  ;
    }else if(selected==null){
      return false  ;
    }
    else{
      return true ;
    }

  }
   Widget checkListTile(int index){
  return  CheckboxListTile(
    checkColor: AppColors.logRed,
      activeColor:AppColors.grey ,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
      dense: true,
      title: Text(
        custodyTypes[index].title!,
        style: const TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
      ),
      value: custodyTypes[index].value!,
      onChanged: (value) {
        setState(() {
          print(value) ;
          for (var element in custodyTypes) {
            element.value = false;
          }
          setState(() {
            print(value) ;
            custodyTypes[index].value= value;
            print(custodyTypes[index].value!) ;
            selected =  custodyTypes[index];
          });

        //  widget.onSelected!(selected) ;
print(selected.toString()) ;
if(selected!.id  == 2) {
  showDialog<void>(

      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return BankList(onClick: (Bank bank){
          setState(() {
            selectedBank  = bank  ;
            selectedBankNm =bank.bankNm! ;
          });
        }


          ,bankList: bankList,) ;


      } );


}
else{
  setState(() {
    selectedBankNm ="" ;

  });
          }
        });
      },
    ) ;
  }
}