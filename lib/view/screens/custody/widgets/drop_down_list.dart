
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
class DropDownList extends StatefulWidget{
  List<User>? employes ;
Function? onChange ;

  DropDownList({this.employes, this.onChange});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return _State();
  }

}
class _State extends State<DropDownList> {
  User? user  ;
  Function? onChange ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     user = widget.employes![0] ;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      DropdownSearch<User>(
        selectedItem: user,
        mode: Mode.BOTTOM_SHEET,
        isFilteredOnline: true,
        showClearButton: true,
        showSearchBox: true,
       // label: 'User *',
        dropdownSearchDecoration: InputDecoration(
            filled: true,
            fillColor:
            Theme.of(context).inputDecorationTheme.fillColor),
        //autoValidate: true,
        validator: (User? u) =>
        u == null ? "user field is required " : null,
        onFind: (String? filter) =>   getData(filter) ,
          onChanged: (User? data) {
          print(data);
          user = data;
        },
      );

   /*   Padding(padding:EdgeInsets.only(bottom: 8.0 , left: 30.0  , right: 30.0 , top: 8.0) ,child:
      SearchableDropdown(
        items: widget.employes?.map((item) {
          return DropdownMenuItem<User>(
              child: Text(item.name!), value: item);
        }).toList(),
        isExpanded: true,
        value: user,
        isCaseSensitiveSearch: true,
        searchHint: Text(
          "select",
          style: TextStyle(fontSize: 20 ,),
        ),
        hint:Text(
            "اسم المورد"
        ),
        iconEnabledColor: AppColors.logRed,
        onChanged: (value) {
          setState(() {
            user = value;
           // print(selectedValue);
          });
        },
      ) ) ;*/
  }
  Future<List<User>> getData(filter) async {
    var response = await Dio().get(
      Constants.GETEMPLOYEE,
      queryParameters: {"filter": filter},
    );
    List<dynamic> list = json.decode(response.data);
    var models = User.fromJsonList(list);
    return models!;
  }


}