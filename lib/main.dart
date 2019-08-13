
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
var currentLocation = LocationData;

var location = new Location();
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  BitmapDescriptor myIcon;
  GlobalKey _globalKey = new GlobalKey();
  List<Marker> allMarkers = [];
 var latitude,longitude;
  GoogleMapController _controllers;
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex ;

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);


  @override
  void initState() {

//    BitmapDescriptor.fromAssetImage(
//        ImageConfiguration(size: Size(25, 25)), 'img/student.png')
//        .then((onValue) {
//      myIcon = onValue;
//      _goToTheLake();
//    });


    // TODO: implement initState
    super.initState();
//
  }
  Future<void> utf()async{

    var _img =NetworkImage('https://c8.alamy.com/comp/HNTYN9/color-circular-frame-with-student-boy-vector-illustration-HNTYN9.jpg');
  _img.obtainKey(new ImageConfiguration(
    size: Size(60,60),
  )).then((val){
    var load = _img.load(val);
    });


  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kLake,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.from(allMarkers),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {

    final GoogleMapController controller = await _controller.future;
    location.onLocationChanged().listen((LocationData currentLocation) {
      setState(() {
        latitude=currentLocation.latitude;
        longitude=currentLocation.longitude;
        allMarkers.add(Marker(

          infoWindow: InfoWindow(title: "papu"),
            markerId: MarkerId('myMarker'),
            draggable: true,

           icon:myIcon,


            onTap: () {
              print('Marker Tapped');
            },
            position: LatLng(latitude,longitude)));


      });



      print(currentLocation.latitude);
      print(currentLocation.longitude);


  final CameraPosition currentloc=  CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 20



      );

    controller.animateCamera(CameraUpdate.newCameraPosition(currentloc));

    });

  }
}