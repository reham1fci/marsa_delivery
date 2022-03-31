import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PiChart extends StatefulWidget{

     @override
  State<PiChart> createState() => _PiChartState();
}

class _PiChartState extends State<PiChart> {
  Map<String, double> dataMap = new Map();
  Api api = Api() ;
  int trans =0;
  int notTrans  =0 ;
  List<Color> colorList = [
    Colors.green,
    Colors.red,
  ];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
}
  getUserData() async {
    SharedPreferences  shared = await SharedPreferences.getInstance();
    User user = User.fromJsonShared(json.decode(shared.getString("user")!));
    Map m  = {"delivery_id":user.userId} ;
    await api.request(url: Constants.Get_Total, map:m, onSuccess: onGetTotalData, onError: onError) ;



  }
  onGetTotalData(var jsonStr){
    var jsonObj = json.decode(jsonStr);
    print(jsonObj) ;
    setState(() {
        trans  = jsonObj['Trans_Ship']  ;
        notTrans  = jsonObj['not_tas_ship']  ;
        dataMap.putIfAbsent(" اجمالي الشحنات الغير مسلمه ", () =>notTrans.toDouble());
        dataMap.putIfAbsent("  اجمالي الشحنات المحولة  ", () =>trans.toDouble());
        print(notTrans) ;
    });


  }

  onError(String err){
    print(err) ;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build


  return PieChart(
    dataMap: dataMap,
    animationDuration: Duration(milliseconds: 800),
    chartLegendSpacing: 16.0,
    chartRadius: MediaQuery.of(context).size.width / 2.7,
    colorList: colorList,
    chartType: ChartType.disc,
  ) ;
}  }
