
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_images.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';
import 'package:marsa_delivery/view/base/dropdown_btn.dart';
import 'package:marsa_delivery/view/screens/requests/widgets/EditText.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AddHolidayReq extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _State();
  }

}
class _State extends State<AddHolidayReq> {
  bool isLoading = false  ;
  TextEditingController reasonEd  =  TextEditingController()  ;
  TextEditingController moneyEd  =  TextEditingController()  ;
  TextEditingController dateEd  =  TextEditingController()  ;
  Api api  = Api() ;
  late SharedPreferences sharedPrefs ;
  DateTime selectedDate = DateTime.now();
  late List<String>holidayType=[]  ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    holidayType.add("test") ;
    holidayType.add("test") ;
    holidayType.add("test") ;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      backgroundColor: AppColors.white,
      appBar: AppBar(
          centerTitle: true,
          iconTheme:  const IconThemeData(color: AppColors.appBarIcon),
          systemOverlayStyle:const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: AppColors.statusAppBar,),
          backgroundColor: AppColors.appBar,title:Text( getTranslated("financial_advance", context)??"",style: const TextStyle(color: AppColors.logRed),) ),

      body:
     // Center(child:
       // SingleChildScrollView(child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            isLoading? const Center(
              child: CircularProgressIndicator(color: AppColors.logRed,),
            ): const SizedBox(),
            //  Spacer() ,

            Padding(padding: const EdgeInsets.only(left: 25 , right: 25 ,top: 30),child:Align(
                alignment: Alignment.centerLeft, child: Text(getTranslated("request", context)??"" ,style: TextStyle(color: AppColors.logRed,fontSize: 20),))) ,
           Padding(padding: EdgeInsets.only(left: 28,right: 28,top: 30),child: Text(getTranslated("req_reason", context)??"",style: TextStyle(fontWeight: FontWeight.bold),),),
           EditText(edTxtController: reasonEd,imageStr: Images.date,color: AppColors.lightGrey, ),
            Padding(padding: EdgeInsets.only(left: 28,right: 28 ,top: 30),child: Text(getTranslated("money_req", context)??"",style: TextStyle(fontWeight: FontWeight.bold),)),

          Padding(padding: EdgeInsets.only(bottom: 8.0 , left: 30.0  , right: 30.0 , top: 8.0)    ,
                child:DropDownBtn(items:holidayType  , onChanged:(value){
                  setState(() {

                  });
                }) ),
     Padding(padding: EdgeInsets.only(left: 28,right: 28,top: 30) ,child:   Expanded(
    child: SizedBox(
   child: Row(

              children: [
                

                Text(getTranslated("from", context)??"",style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 200,) ,
                Text(getTranslated("to", context)??"",style: TextStyle(fontWeight: FontWeight.bold)),
            ],) ))),
     Row(
    children: [
     Flexible(child:
    EditText(edTxtController: dateEd ,imageStr: Images.date,color:  AppColors.logRed,onTap:(){
    _selectDate() ;
    } ,),),
      //SizedBox(width: 50,) ,

      Flexible(child:
    EditText(edTxtController: dateEd ,imageStr: Images.date,color:  AppColors.logRed,onTap:(){
    _selectDate() ;
    } ,),),

    ],),
            Padding(padding: const EdgeInsets.only(top: 100),child:  CustomBtn(buttonNm: getTranslated("add", context)??"", onClick: onAddBtn ,  backBtn:AppColors.logRed, txtColor: AppColors.white,)),

     ],)

     // ),
      //),
    );
  }
  onAddBtn(){}
  _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        var formatter =  DateFormat("dd/MM/yyyy");
        String formattedDate = formatter.format(selectedDate);
        dateEd.text =formattedDate ;
      });
    }
  }

}