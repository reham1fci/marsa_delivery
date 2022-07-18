
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';
import 'package:marsa_delivery/view/base/no_thing_to_show.dart';
import 'package:marsa_delivery/view/screens/points_sale/widegts/client_search_view.dart';
class EmployeeSearch extends StatefulWidget{
  Function? onClick ;

  EmployeeSearch({this.onClick});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return _State();
  }

}
class _State extends State<EmployeeSearch> {
  bool isLoading = true  ;
   List<User> employee  =[];
   List<User> filterList  =[];
  User? selectedEmployee ;
  TextEditingController userNameEd  =  TextEditingController()  ;
  TextEditingController passEd  =  TextEditingController()  ;
  Api api = Api() ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filterList  = employee ;

    api.getRequest(url: Constants.GETEMPLOYEE, onSuccess: onGetRequest, onError: (err){
      print(err) ;
    });

  }
  onGetRequest( var jsonObj){

    print (jsonObj);
    setState(() {
      isLoading = false;
    });
    List<dynamic> list = json.decode(jsonObj);
    for(int i  = 0 ; i<list.length ; i++){
      print(list[i]) ;
      User user = User.fromJsonEmployee(list[i]) ;
      setState(() {

        employee.add(user) ;

      });
    }




  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return
           AlertDialog(
       title: Text(getTranslated("emp_name", context)??"" , style: TextStyle(color: AppColors.logRed),),
       content:

         employee.isNotEmpty ?  Container( height :double.infinity,width:300,child:   Column(children: [
           ClientSearchView(onChanged: (string){
             setState(() {
               filterList =
                   employee
                       .where((u) =>
                   (u.name!
                       .toLowerCase()
                       .contains(string.toLowerCase()) ||
                       u.userId!.toLowerCase().contains(
                           string.toLowerCase())))
                       .toList();
             });
           },onSearchEnd:(){
             setState(() {
               filterList=employee ;

             });
           },onFilter: (){

           },),
           Expanded( child:   ListView.builder(
            shrinkWrap: true,

             itemBuilder: (context, index) {
               return listItem(index);
             }, itemCount: filterList.length,) , flex: 1,)

         ],)):const Center(
           child: CircularProgressIndicator(),
         ) ,
           /*  actions: [
               CustomBtn(buttonNm: getTranslated("confirm", context)??"", onClick: (){
                 widget.onClick!(selectedEmployee)  ;
                 Navigator.of(context).pop() ;
               } ,  backBtn:AppColors.logRed, txtColor: AppColors.white,),
             ],*/


     );

    /* employee.isNotEmpty ?  Container( height :double.infinity,child:   Column(children: [
     ClientSearchView(onChanged: (string){
       setState(() {
         filterList =
             employee
                 .where((u) =>
             (u.name!
                 .toLowerCase()
                 .contains(string.toLowerCase()) ||
                 u.userId!.toLowerCase().contains(
                     string.toLowerCase())))
                 .toList();
       });
     },onSearchEnd:(){
       setState(() {
         filterList=employee ;

       });
     },onFilter: (){

     },),
     Expanded( child:   ListView.builder(
       shrinkWrap: true,

       itemBuilder: (context, index) {
         return listItem(index);
       }, itemCount: filterList.length,) , flex: 1,)

   ],)):const NoThingToShow() ;*/

  }
 Widget listItem(int index){
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedEmployee = filterList[index] ;
           widget.onClick!(selectedEmployee) ;
          Navigator.of(context).pop() ;

        });
      },
        child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(padding:const EdgeInsets.all(10.0) ,
                child:  Text(filterList[index].name!),) , Divider(color: AppColors.appBarIcon,)
            ],) ,

        //Padding(padding:const EdgeInsets.all(5.0)
    );
  }
  }

