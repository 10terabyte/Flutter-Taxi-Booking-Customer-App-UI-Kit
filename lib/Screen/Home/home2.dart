import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:com_basoft_customer_ba/theme/style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;
import 'package:com_basoft_customer_ba/Screen/Menu/menu_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:flutter/cupertino.dart';

class HomeScreen2 extends StatefulWidget {
  @override
  _HomeScreen2State createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  // _HomeScreen2State();
  final String screenName = "HOME2";
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  List<LatLng> points = <LatLng>[];
  GoogleMapController? _mapController;

  Map<MarkerId, Marker>? markers = <MarkerId, Marker>{};
  Map<CircleId, Circle>? circles = <CircleId, Circle>{};
  MarkerId? selectedMarker;
  BitmapDescriptor? _markerIcon;
  CircleId? selectedCircle;

  Map<PolylineId, Polyline>? polylines = <PolylineId, Polyline>{};
  PolylineId? selectedPolyline;
  bool checkPlatform = Platform.isIOS;
  Position? _position;
  String placemark = '';
  double? distance = 0;
  LatLng currentLocation = LatLng(39.170655, -95.449974);
  List<Map<String, dynamic>> listDistance = [{"id": 1, "title": "5 km"},{"id": 2, "title": "10 km"},{"id":3,"title": "15 km"}];
  String selectedDistance = "1";
  double _radius = 5000;

  List<dynamic> dataMarKer = [
    {
      "id": "1",
      "lat": 39.170655,
      "lng": -95.449974
    },{
      "id": "2",
      "lat": 39.165576,
      "lng": -95.457672
    },{
      "id": "3",
      "lat": 39.155726,
      "lng": -95.429189
    },{
      "id": "4",
      "lat": 39.183142,
      "lng": -95.438454
    },{
      "id": "5",
      "lat": 39.153597,
      "lng": -95.385606
    },{
      "id": "6",
      "lat": 39.179682,
      "lng": -95.406882
    },{
      "id": "7",
      "lat": 39.150934,
      "lng": -95.524604
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    this._mapController = controller;
    _mapController?.animateCamera(
        CameraUpdate?.newCameraPosition(
            CameraPosition(
              target: LatLng(currentLocation.latitude,currentLocation.longitude),
              zoom: 12,
            )
        )
    );
    _addCircle();

    for(int i=0;i<dataMarKer.length;i++){
      distance = calculateDistance(currentLocation.latitude,currentLocation.longitude,dataMarKer[i]['lat'],dataMarKer[i]['lng']);
      if(distance!*1000 < _radius){
        _addMarker(dataMarKer[i]['id'], dataMarKer[i]['lat'], dataMarKer[i]['lng']);
      }
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    Position? position;
    try {
      final Geolocator geolocator = Geolocator();
        // ..forceAndroidLocationManager = true;
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
    } on PlatformException {
      position = null;
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _position = position;

    });
    // List<Placemark> placemarks = await Geolocator().placemarkFromCoordinates(_position.latitude, _position.longitude);
    // if (placemarks != null && placemarks.isNotEmpty) {
    //   final Placemark pos = placemarks[0];
    //   setState(() {
    //     placemark = pos.thoroughfare + ', ' + pos.locality;
    //
    //   });
    // }
  }


  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration =
      createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(
          imageConfiguration, checkPlatform ? 'assets/image/marker/car_top_48.png' : "assets/image/marker/car_top_96.png")
          .then(_updateBitmap);
    }
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }

  void _addMarker(String markerIdVal, double lat, double lng) async {
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lat, lng),
      // icon: checkPlatform ? BitmapDescriptor.fromAsset("assets/image/marker/car_top_48.png") : BitmapDescriptor.fromAsset("assets/image/marker/car_top_96.png"),
      onTap: () {
        // _onMarkerTapped(markerId);
      },
    );
    setState(() {
      markers?[markerId] = marker;
    });
  }

  void _addCircle() {
    final int circleCount = circles?.length ?? 0;
    if (circleCount == 12) {
      return;
    }
    final String circleIdVal = 'circle_id';
    final CircleId circleId = CircleId(circleIdVal);

    final Circle circle = Circle(
      circleId: circleId,
      consumeTapEvents: true,
      strokeColor: Color.fromRGBO(135, 206, 250, 0.9),
      fillColor: Color.fromRGBO(135, 206, 250, 0.3),
      strokeWidth: 4,
      center: LatLng(currentLocation.latitude,currentLocation.longitude),
      radius: _radius,
    );
    setState(() {
      circles?[circleId] = circle;
    });
  }

  /// Widget change the radius Circle.

  Widget getListOptionDistance() {
    final List<Widget> choiceChips = listDistance.map<Widget>((value) {
      return Padding(
          padding: const EdgeInsets.all(3.0),
          child: ChoiceChip(
              key: ValueKey<String>(value['id'].toString()),
              labelStyle: textGrey,
              backgroundColor: greyColor2,
              selectedColor: primaryColor,
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
              selected: selectedDistance == value['id'].toString(),
              label: Text((value['title'])),
              onSelected: (bool check) {
                setState(() {
                  selectedDistance = check ? value["id"].toString() : '';
                  changeCircle(selectedDistance);
                });
              })
      );
    }).toList();
    return Wrap(
        children: choiceChips
    );
  }

  ///Filter and display markers in that area
  ///My data is demo. You can get data from your api and use my function
  ///to filter and display markers around the current location.

  changeCircle(String selectedCircle){
    if(selectedCircle == "1"){
      setState(() {
        _radius = 5000;
        _moveCamera(11.5);
      });
    }
    if(selectedCircle == "2"){
      setState(() {
        _radius = 10000;
        _moveCamera(11.2);
      });
    }
    if(selectedCircle == "3"){
      setState(() {
        _radius = 15000;
        _moveCamera(10.5);
      });
    }
    _addCircle();
    for(int i=0;i<dataMarKer.length;i++){
      distance = calculateDistance(currentLocation.latitude,currentLocation.longitude,dataMarKer[i]['lat'],dataMarKer[i]['lng']);
      if(distance!*1000 < _radius){
        _addMarker(dataMarKer[i]['id'], dataMarKer[i]['lat'], dataMarKer[i]['lng']);
      } else {
        print(dataMarKer[i]['id']);
        _remove(dataMarKer[i]['id']);
      }
    }
  }

  void _remove(String idMarker) {
    final MarkerId markerId = MarkerId(idMarker);
    setState(() {
      markers?.remove(markerId);
    });
  }

  _moveCamera(double zoom){
    _mapController?.animateCamera(
      CameraUpdate?.newCameraPosition(
          CameraPosition(
            target: LatLng(currentLocation.latitude,currentLocation.longitude),
            zoom: zoom,
          )
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    _createMarkerImageFromAsset(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuScreens(activeScreenName: screenName),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: GoogleMap(
                          circles: Set<Circle>.of(circles?.values ?? []),
                          onMapCreated: _onMapCreated,
                          myLocationEnabled: false,
                          myLocationButtonEnabled: false,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(currentLocation.latitude,currentLocation.longitude),
                            zoom: 12,
                          ),
                          markers: Set<Marker>.of(markers?.values ?? []),
                        )
                    ),

                  ],
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        centerTitle: true,
                        leading: TextButton(
                            onPressed: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            child: Icon(Icons.menu,color: blackColor,)
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0,right: 10.0),
                        child: getListOptionDistance(),
                      )
                    ],
                  ),
                ),

              ],
            )
        ),
      ),
    );
  }
}
