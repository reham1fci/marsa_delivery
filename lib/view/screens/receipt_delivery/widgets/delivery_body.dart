
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/Shipment.dart';
import 'package:marsa_delivery/model/User.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/view/base/alert_dialog.dart';
import 'package:marsa_delivery/view/base/get_current_location.dart';
import 'package:marsa_delivery/view/base/no_thing_to_show.dart';
import 'package:marsa_delivery/view/screens/points_sale/widegts/client_search_view.dart';
import 'package:marsa_delivery/view/screens/receipt_delivery/widgets/delivery_item.dart';
import 'package:marsa_delivery/view/screens/receipt_delivery/widgets/shipment_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryBody extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _State();
  }

}
class _State extends State<DeliveryBody> {
  late List<Shipment> shipmentList  =[];
  late List<Shipment> selectShipment  =[];
  late List<Shipment> filterList  =[];
  Color cardColor = AppColors.white  ;
  Api api  = Api() ;
  User? user ;
  final GestureDetectorKey = GlobalKey<RawGestureDetectorState>();
  bool loading  = true  ;
  CurrentLoc currentLoc  = CurrentLoc() ;
  bool firstTime = true  ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData()  ;
  }

  getUserData() async {
    shipmentList  =[];
     filterList  =shipmentList;

    if(firstTime){
      SharedPreferences  shared = await SharedPreferences.getInstance();
      user = User.fromJsonShared(json.decode(shared.getString("user")!));
   await currentLoc.getCurrentLocation(onGetLocation:(lat , lng){
      setState(() {
        user?.lat = lat.toString() ;
        user?.lng = lng.toString() ;
      });
      print(lat);
      print(lng)  ;

    } );
   firstTime  = false  ;
    }
    setState(() {
      loading= true ;

    });
    Map m  = {"delivery_id":user?.userId} ;
    await api.request(url: Constants.Deliovery_Url, map: m, onSuccess: onGetRequest, onError: (err){

    });

  }
  onGetRequest( var jsonObj) async {
    print (jsonObj);
    List<dynamic> list = json.decode(jsonObj);
    setState(() {
       loading  = false  ;
    });

    for(int i  = 0; i<list.length ; i++){
      print(list[i]) ;
      Shipment ship = Shipment.fromJsonDelivery(list[i]) ;
      if(ship.lat!.isNotEmpty&&ship.lng!.isNotEmpty){
      double distanceMeter  = await getDistanceBetween(double.parse(ship.lat!), double.parse(ship.lng!)) ;
    ship.distanceBetween   = distanceMeter / 1000  ;
     print( ship.distanceBetween ) ;
      }
      else{
        ship.distanceBetween  = 0  ;
      }
      print(ship.distanceBetween) ;
      setState(() {
        shipmentList.add(ship) ;

      });

    }
setState(() {
 // shipmentList.sort((a, b) => b.distanceBetween!.compareTo(a.distanceBetween!));
  filterList.sort((a, b) => a.distanceBetween!.compareTo(b.distanceBetween!));

});


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Scaffold(
          appBar: AppBar(backgroundColor: AppColors.colorPrimary,title: Text(getTranslated("shipment_delivery", context)??""),),
          body:  loading? const Center(child:CircularProgressIndicator(color: AppColors.logRed,)):  shipmentList.isNotEmpty ?   Container( height :double.infinity,child:   Column(children: [
              ClientSearchView(onChanged: (string){
          setState(() {
          filterList =
          shipmentList
              .where((u) =>
          (u.customerNm!
              .toLowerCase()
              .contains(string.toLowerCase()) ||
          u.customerMobile!.toLowerCase().contains(
          string.toLowerCase())))
              .toList();
          });
          },onSearchEnd:(){
            setState(() {
              filterList=shipmentList ;

            });
          },onFilter: (){

          },),
        Expanded(child:  ListView.builder(
            itemBuilder: (context  , index ){
              return
                DeliveryItem(index: index, list: filterList ,onRefresh: getUserData,mUser: user!,) ;
            } ,itemCount:  filterList.length , ),flex: 1 ,)]))
              :const NoThingToShow() ,
      );
  }

   Future<double>  getDistanceBetween(double lat , double lng)  async {

  double _distanceInMeters = await  Geolocator.distanceBetween(
    lat,
    lng,
    double.parse(user!.lat!),
    double.parse(user!.lng!),
  );
  return _distanceInMeters  ;
}
 /* double calculateDistance(lat1, lon1){
    double  lat2 =   double.parse(user!.lat!) ;
   double  lon2  =  double.parse(user!.lng!)   ;
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }*/

}