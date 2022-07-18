
import 'dart:async';
import 'dart:math';

import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart' ;

const kGoogleApiKey = "AIzaSyCU4yWMj9Uad8gIpMpNhSWxWZWECL__CMg";
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();

class _MyAppState extends State<MyApp> {
  Mode _mode = Mode.overlay;

  String location ='Null, Press Button';
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
  Future<void> GetAddressFromLatLong(Position position)async {
    List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    geocoding.Placemark place = placemarks[0];
    Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
     print(Address) ;
    setState(()  {
    });
  }
   @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
   getCurrentLocation() async{
     Position position = await _getGeoLocationPosition();
     location ='Lat: ${position.latitude} , Long: ${position.longitude}';
      setState(() {
        currentLoc  = Location(lat:position.latitude,lng:  position.longitude);
      });
     GetAddressFromLatLong(position);
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: Text("My App"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildDropdownMenu(),
              ElevatedButton(
                onPressed: _handlePressButton,
                child: Text("Search places"),
              ),
              ElevatedButton(
                child: Text("Custom"),
                onPressed: () {
                 Navigator.push(context,
                     MaterialPageRoute(builder: (context) => CustomSearchScaffold())) ;                },
              ),
            ],
          )),
    );
  }

  Widget _buildDropdownMenu() => DropdownButton(
    value: _mode,
    items: <DropdownMenuItem<Mode>>[
      DropdownMenuItem<Mode>(
        child: Text("Overlay"),
        value: Mode.overlay,
      ),
      DropdownMenuItem<Mode>(
        child: Text("Fullscreen"),
        value: Mode.fullscreen,
      ),
    ],
   onChanged: ( Mode? value){
      setState(() {
        _mode  = value! ;
      });
   },
  );

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState?.showSnackBar(
      SnackBar(content: Text(response.errorMessage!)),
    );
  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Position position = await _getGeoLocationPosition();
    location ='Lat: ${position.latitude} , Long: ${position.longitude}';
    setState(() {
      currentLoc  = Location(lat:position.latitude,lng:  position.longitude);
    });
    GetAddressFromLatLong(position);     print(" loc" +currentLoc.toString()) ;
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
        components: [Component(Component.country, "sa")]
      // components: [Component(Component.country, "uk")],
    );

    displayPrediction(p!, homeScaffoldKey.currentState!);
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
    final lat = detail.result.geometry?.location.lat;
    final lng = detail.result.geometry?.location.lng;

    scaffold.showSnackBar(
      SnackBar(content: Text("${p.description} - $lat/$lng")),
    );
  }
}

// custom scaffold that handle search
// basically your widget need to extends [GooglePlacesAutocompleteWidget]
// and your state [GooglePlacesAutocompleteState]
class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold()
      : super(
    apiKey: kGoogleApiKey,
    sessionToken: Uuid().generateV4(),
   // language: "en",
   // components: [Component(Component.country, "uk")],
  );

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: AppBarPlacesAutoCompleteTextField());
    final body = PlacesAutocompleteResult(
      onTap: (p) {
        displayPrediction(p, searchScaffoldKey.currentState!);
      },
      logo: Row(
        children: [FlutterLogo()],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
    return Scaffold(key: searchScaffoldKey, appBar: appBar, body: body);
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
    searchScaffoldKey.currentState?.showSnackBar(
      SnackBar(content: Text(response.errorMessage!)),
    );
  }
@override
  void onResponse(PlacesAutocompleteResponse? response) {
    // TODO: implement onResponse 
    super.onResponse(response);
    if (response != null && response.predictions.isNotEmpty) {
      searchScaffoldKey.currentState?.showSnackBar(
        SnackBar(content: Text("Got answer")),
      );
    }
  }
}

class Uuid {
  final Random _random = Random();

  String generateV4() {
    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    final int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);

  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}
