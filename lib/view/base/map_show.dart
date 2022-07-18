import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/utill/app_color.dart';

class MapShow extends StatefulWidget{
   LatLng position  ;

   MapShow(this.position);

  @override
  State<MapShow> createState() => _MapShowState();
}

class _MapShowState extends State<MapShow> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  LatLng _center =  LatLng(9.669111, 80.014007);
 //  GoogleMapController mapController  = GoogleMapController ();
  void _onMapCreated(GoogleMapController controller) {
//    mapController = controller;

    final marker = Marker(
      markerId: MarkerId('place_name'),
      position:widget.position,
      // icon: BitmapDescriptor.,
      infoWindow: InfoWindow(
        title: 'هنا',
        snippet: getTranslated("client_loc", context),
      ),
    );

    setState(() {
      markers[MarkerId('place_name')] = marker;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
     Scaffold(
      appBar: AppBar(

    backgroundColor: AppColors.colorPrimary,
    ) ,
      body:
        GoogleMap(//Map widget from google_maps_flutter package
          onMapCreated: _onMapCreated,
          markers: Set<Marker>.of(markers.values),
      zoomGesturesEnabled: true, //enable Zoom in, out on map
      initialCameraPosition: CameraPosition(//innital position in map
        target: widget.position, //initial position
        zoom: 15.0, //initial zoom level
      ),
     ) ,  );
  }
}