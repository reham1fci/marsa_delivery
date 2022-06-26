
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/model/bank.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';
import 'package:marsa_delivery/view/base/no_thing_to_show.dart';
import 'package:marsa_delivery/view/screens/points_sale/widegts/client_search_view.dart';
class BankList extends StatefulWidget{
  Function? onClick ;
List<Bank>bankList  =  []  ;

  BankList({this.onClick ,required this.bankList});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _State();
  }

}
class _State extends State<BankList> {


 /* @override
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




  }*/
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      AlertDialog(
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text(getTranslated("cancel", context)??"" ,style: TextStyle(color: AppColors.logRed),))
        ],
        title: Text(getTranslated("bank", context)??"" , style: TextStyle(color: AppColors.logRed),),
        content:

        widget.bankList.isNotEmpty ?  Container(width:300,height:400,child:   Column(children: [
           ListView.builder(
            shrinkWrap: true,

            itemBuilder: (context, index) {
              return listItem(index);
            }, itemCount: widget.bankList.length,)

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
          widget.onClick!(widget.bankList[index]) ;
          Navigator.of(context).pop() ;

        });
      },
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding:const EdgeInsets.all(10.0) ,
            child:  Text(widget.bankList[index].bankNm!),) , Divider(color: AppColors.appBarIcon,)
        ],) ,

      //Padding(padding:const EdgeInsets.all(5.0)
    );
  }
}

