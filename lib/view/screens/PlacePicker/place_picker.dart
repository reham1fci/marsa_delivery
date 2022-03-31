
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:math';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart' ;
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/view/base/custom_button.dart';
import 'package:marsa_delivery/view/screens/search_location.dart';

const kGoogleApiKey = "AIzaSyCU4yWMj9Uad8gIpMpNhSWxWZWECL__CMg";
class PlacePicker extends StatefulWidget{
  const PlacePicker({Key? key}) : super(key: key);


  @override
  State<PlacePicker> createState() => _PlacePickerState();
}
final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();
class _PlacePickerState extends State<PlacePicker> {
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(24.774265, 46.738586);
  String location = "Location Name:";
  Mode _mode = Mode.overlay;
 bool loading  = true  ;
  Location currentLoc  = Location(lat:24.774265 ,lng:  46.738586,);
  String Address = 'search';

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  Future<void> GetAddressFromLatLong(LatLng position)async {
    List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    geocoding.Placemark place = placemarks[0];
    Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    print(Address) ;
    setState(()  {
    });
  }
 getCurrentLocation() async{
    Position position = await _getGeoLocationPosition();
    location ='Lat: ${position.latitude} , Long: ${position.longitude}';
    print(location) ;
    setState(() {
      currentLoc  = Location(lat:position.latitude,lng:  position.longitude);
      startLocation =LatLng(currentLoc.lat, currentLoc.lng) ;
      loading  = false ;

    });
    GetAddressFromLatLong(LatLng(position.latitude, position.longitude));
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState?.showSnackBar(
      SnackBar(content: Text(response.errorMessage!)),
    );
  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
   setState(() {
      loading = true   ;

    });
    print(" loc" +currentLoc.toString()) ;
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        radius: 5000,
        onError: onError,
        mode: _mode,
        offset: 0,
        location:currentLoc,
        // region: "ar",
        types: [],
        strictbounds: false,
        //  language: "en",
        decoration: InputDecoration(
          hintText: 'Search',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
        language: "ar",
        components: [Component(Component.country, "eg")]
      // components: [Component(Component.country, "uk")],
    );
 if(p != null){
    displayPrediction(p, homeScaffoldKey.currentState!);
 }
 else {
   setState(() {
     loading = false;
   });
 }
}


Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
  if (p != null) {
    // get detail (lat/lng)
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId!);
    if(detail != null){
    final lat = detail.result.geometry?.location.lat;
    final lng = detail.result.geometry?.location.lng;
setState(() {
  currentLoc= Location(lat: lat!  , lng:lng!) ;
  startLocation =LatLng(currentLoc.lat, currentLoc.lng) ;
Address =p.description!  ;
  loading = false  ;
});
    scaffold.showSnackBar(
      SnackBar(content: Text("${p.description} - $lat/$lng")),

    );
  }}
  else{
    setState(() {
      loading = false ;
    });
  }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
getCurrentLocation() ;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(

      key: homeScaffoldKey,
        appBar: AppBar(
          title: Text(getTranslated("search", context)??""),
          backgroundColor: AppColors.colorPrimary,
          actions: [Expanded(child: TextButton.icon(onPressed: _handlePressButton, icon: Icon(Icons.search ,color: Colors.white,), label: Text(getTranslated("search", context)??"",style:  TextStyle(color: Colors.white),)))],
        ),floatingActionButton: FloatingActionButton(onPressed:  (){
      setState(() {
        Map m  = {
          "lat": currentLoc.lat,
          "lng": currentLoc.lng,
          "address":Address,
        } ;
        Navigator.of(context).pop(m);

      });
    } ,child:Text(getTranslated("save", context)??"") ,backgroundColor: AppColors.logRed,),
        body:  loading? const Center(
          child: CircularProgressIndicator(color: AppColors.logRed,),
        ):Stack(
            children:[

              GoogleMap(//Map widget from google_maps_flutter package

                zoomGesturesEnabled: true, //enable Zoom in, out on map
                initialCameraPosition: CameraPosition( //innital position in map
                  target: startLocation, //initial position
                  zoom: 15.0, //initial zoom level
                ),
                mapType: MapType.normal, //map type
                onMapCreated: (controller) { //method called when map is created
                  setState(() {
                    mapController = controller;
                  });
                },
                onCameraMove: (CameraPosition cameraPositiona) {
                  cameraPosition = cameraPositiona; //when map is dragging
                },
                onCameraIdle: () async { //when map drag stops
                  List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(cameraPosition!.target.latitude, cameraPosition!.target.longitude);
                  setState(() { //get place name from lat and lang
                    location =  'lat ${cameraPosition!.target.latitude}+ lng${cameraPosition!.target.longitude} ';
                    currentLoc =Location(lat: cameraPosition!.target.latitude, lng: cameraPosition!.target.longitude) ;
                    GetAddressFromLatLong(LatLng(cameraPosition!.target.latitude, cameraPosition!.target.longitude)) ;
                  });
                },
              ),

          Center( //picker image on google map
                child: Image.asset("assets/images/picker.png",width: 50,)
              ),


              Positioned(  //widget to display location name
                  bottom:100,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Card(
                      child: Container(
                          padding: EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width - 40,
                          child: ListTile(
                            leading: Image.asset("assets/images/picker.png", width: 25,),
                            title:Text(Address, style: TextStyle(fontSize: 18),),
                            dense: true,
                          )
                      ),
                    ),
                  )
              )      ,    /* Positioned(  //widget to display location name
                  bottom:20,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                  child: CustomBtn(buttonNm: getTranslated("save", context)??"", backBtn: AppColors.logRed, txtColor: Colors.white, onClick: (){
                    setState(() {
                      Map m  = {
                        "lat": currentLoc.lat,
                        "lng": currentLoc.lng,
                        "address":Address,
                      } ;
                      Navigator.of(context).pop(m);

                    });
                  }),
                  )
              )*/
            ]
        )
    );
  }
}