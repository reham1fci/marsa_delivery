import 'package:flutter/material.dart';
import 'package:marsa_delivery/utill/app_color.dart';

class DropDownBtn extends StatefulWidget{
 List<String>items = [] ;
 Function onChanged;

 DropDownBtn({required this.items, required this.onChanged,});

  @override
  State<DropDownBtn> createState() => _DropDownBtnState();
}

class _DropDownBtnState extends State<DropDownBtn> {

   String dropdownvalue  ="" ;
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownvalue  = widget.items[0] ;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Container(
    color: AppColors.lightGrey,
        child:DropdownButton<String>(

      isExpanded: true,
      underline: SizedBox(),
      //  dropdownColor:AppColors.lightGrey,
        // Initial Value
   //   value: dropdownvalue,

      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),
      hint:Text( dropdownvalue,),

      // Array list of items
      items: widget.items.map((String value) {
        return  DropdownMenuItem<String>(
          value: value,
          child:  Text(value),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? string ){
        setState(() {
          dropdownvalue  = string!  ;
        });
      widget.onChanged(string) ;
      },
        )  );
  }
    refresh() {
     setState(() {});
   }
}