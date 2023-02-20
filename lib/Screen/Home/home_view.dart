import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:com_basoft_customer_ba/Blocs/place_bloc.dart';
import 'package:com_basoft_customer_ba/Components/select_address_view.dart';
import 'package:com_basoft_customer_ba/Model/map_type_model.dart';
import 'package:com_basoft_customer_ba/Model/place_model.dart';
import 'package:com_basoft_customer_ba/Screen/Menu/menu_screen.dart';
import 'package:com_basoft_customer_ba/Screen/SearchAddress/search_address_screen.dart';
import 'package:com_basoft_customer_ba/theme/style.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'select_map_type.dart';

class HomeView extends StatefulWidget {
  final PlaceBloc? placeBloc;
  HomeView({this.placeBloc});
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final String screenName = "HOME";
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  CircleId? selectedCircle;
  int _markerIdCounter = 0;
  GoogleMapController? _mapController;
  BitmapDescriptor? markerIcon;
  String _placemark = '';
  GoogleMapController? mapController;
  CameraPosition? _position;
  bool checkPlatform = Platform.isIOS;
  bool nightMode = false;
  VoidCallback? showPersBottomSheetCallBack;
  List<MapTypeModel> sampleData = <MapTypeModel>[];
  PersistentBottomSheetController? _controller;

  Position? currentLocation;
  Position? _lastKnownPosition;
  final Geolocator _locationService = Geolocator();
  PermissionStatus? permission;
  bool isEnabledLocation = false;

  @override
  void initState() {
    super.initState();
//    _initLastKnownLocation();
//    _initCurrentLocation();
    fetchLocation();
    showPersBottomSheetCallBack = _showBottomSheet;
    sampleData.add(MapTypeModel(1,true, 'assets/style/maptype_nomal.png', 'Nomal', 'assets/style/nomal_mode.json'));
    sampleData.add(MapTypeModel(2,false, 'assets/style/maptype_silver.png', 'Silver', 'assets/style/sliver_mode.json'));
    sampleData.add(MapTypeModel(3,false, 'assets/style/maptype_dark.png', 'Dark', 'assets/style/dark_mode.json'));
    sampleData.add(MapTypeModel(4,false, 'assets/style/maptype_night.png', 'Night', 'assets/style/night_mode.json'));
    sampleData.add(MapTypeModel(5,false, 'assets/style/maptype_netro.png', 'Netro', 'assets/style/netro_mode.json'));
    sampleData.add(MapTypeModel(6,false, 'assets/style/maptype_aubergine.png', 'Aubergine', 'assets/style/aubergine_mode.json'));
  }

  ///Get last known location
  Future<void> _initLastKnownLocation() async {
    Position? position;
    try {
      final Geolocator geolocator = Geolocator();
        // ..forceAndroidLocationManager = true;
      position = await Geolocator?.getLastKnownPosition(); //desiredAccuracy: LocationAccuracy.best
    } on PlatformException {
      position = null;
    }
    if (!mounted) {return;}
    _lastKnownPosition = position;
  }

  Future<void> checkPermission() async {
    isEnabledLocation = await Permission.location.serviceStatus.isEnabled;
  }

  void fetchLocation(){
    checkPermission()?.then((_) {
      if(isEnabledLocation){
        _initCurrentLocation();
      }
    });
  }

  /// Get current location
  Future<void> _initCurrentLocation() async {
    currentLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);

      // List<Placemark> placemarks = await Geolocator()?.placemarkFromCoordinates(currentLocation?.latitude, currentLocation?.longitude);
      // if (placemarks != null && placemarks.isNotEmpty) {
      //   final Placemark pos = placemarks[0];
      //   setState(() {
      //     _placemark = pos.name + ', ' + pos.thoroughfare;
      //   });
      //   widget?.placeBloc?.getCurrentLocation(Place(
      //       name: _placemark,
      //       formattedAddress: "",
      //       lat: currentLocation?.latitude,
      //       lng: currentLocation?.longitude
      //   ));
      // }
    if(currentLocation != null){
      moveCameraToMyLocation();
    }
  }

  void moveCameraToMyLocation(){
    _mapController?.animateCamera(
      CameraUpdate?.newCameraPosition(
        CameraPosition(
          target: LatLng(currentLocation?.latitude ?? 0,currentLocation?.longitude ?? 0),
          zoom: 14.0,
        ),
      ),
    );
  }

  /// Get current location name
  void getLocationName(double lat, double lng) async {
    // if(lat != null && lng != null) {
    //   List<Placemark> placemarks = await Geolocator()?.placemarkFromCoordinates(lat, lng);
    //   if (placemarks != null && placemarks.isNotEmpty) {
    //     final Placemark pos = placemarks[0];
    //       _placemark = pos.name + ', ' + pos.thoroughfare;
    //       print(_placemark);
    //     widget?.placeBloc?.getCurrentLocation(Place(
    //       name: _placemark,
    //       formattedAddress: "",
    //       lat: lat,
    //       lng: lng
    //     ));
    //   }
    // }
  }

  void _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    MarkerId markerId = MarkerId(_markerIdVal());
    LatLng position = LatLng(currentLocation?.latitude ?? 0.0, currentLocation?.longitude ?? 0.0);
    Marker marker = Marker(
      markerId: markerId,
      position: position,
      draggable: false,
      // icon: checkPlatform ? BitmapDescriptor.fromAsset("assets/image/marker/ic_pick_48.png") : BitmapDescriptor.fromAsset("assets/image/marker/ic_pick_96.png"),
    );
    setState(() {
      _markers[markerId] = marker;
    });
    Future.delayed(Duration(milliseconds: 200), () async {
      _mapController = controller;
      controller?.animateCamera(
        CameraUpdate?.newCameraPosition(
          CameraPosition(
            target: position,
            zoom: 15.0,
          ),
        ),
      );
    });
  }

  String _markerIdVal({bool increment = false}) {
    String val = 'marker_id_$_markerIdCounter';
    if (increment) _markerIdCounter++;
    return val;
  }

  Future<String> _getFileData(String path) async {
    return await rootBundle.loadString(path);
  }

  void _setMapStyle(String mapStyle) {
    setState(() {
      nightMode = true;
      _mapController?.setMapStyle(mapStyle);
    });
  }

  void changeMapType(int id, String fileName){
    if (fileName == null) {
      setState(() {
        nightMode = false;
        _mapController?.setMapStyle(null);
      });
    } else {
      _getFileData(fileName)?.then(_setMapStyle);
    }
  }

  void _showBottomSheet() async {
    setState(() {
      showPersBottomSheetCallBack = null;
    });
    _controller = await _scaffoldKey.currentState
        ?.showBottomSheet((context) {
      return Container(
        height: 300.0,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Map type",style: heading18Black,),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.close,color: blackColor,),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
              Expanded(
                child:
                GridView.builder(
                  itemCount: sampleData.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      highlightColor: Colors.red,
                      splashColor: Colors.blueAccent,
                      onTap: () {
                        _closeModalBottomSheet();
                        sampleData.forEach((element) => element.isSelected = false);
                        sampleData[index].isSelected = true;
                        changeMapType(sampleData[index].id, sampleData[index].fileName);

                      },
                      child: SelectMapTypeView(sampleData[index]),
                    );
                  },
                ),
              )

            ],
          ),
        )
      );
    });
  }

  void _closeModalBottomSheet() {
    if (_controller != null) {
      _controller?.close();
      _controller = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        key: _scaffoldKey,
        drawer: MenuScreens(activeScreenName: screenName),
        body: Stack(
          children: <Widget>[
            SizedBox(
              //height: MediaQuery.of(context).size.height - 180,
              child: GoogleMap(
                markers: Set<Marker>.of(_markers.values),
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                compassEnabled: false,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(45.521563, -122.677433),
                  zoom: 11.0,
                ),
                onCameraMove: (CameraPosition position) {
                  // if(_markers.length > 0) {
                  //   MarkerId markerId = MarkerId(_markerIdVal());
                  //   Marker marker = _markers[markerId];
                  //   Marker updatedMarker = marker?.copyWith(
                  //     positionParam: position?.target,
                  //   );
                  //   setState(() {
                  //     _markers[markerId] = updatedMarker;
                  //     _position = position;
                  //   });
                  // }
                },
                onCameraIdle: () => getLocationName(
                     _position?.target?.latitude ?? currentLocation?.latitude ?? 0,
                     _position?.target?.longitude ?? currentLocation?.longitude ?? 0
                ),
              ),
            ),

            Positioned(
              bottom: 30.0,
              left: 20.0,
              right: 20.0,
              child: Container(
                  height: 150.0,
                  child: SelectAddress(
                    fromAddress: widget?.placeBloc?.formLocation?.name,
                    toAddress: "To address",
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SearchAddressScreen(),
                          fullscreenDialog: true
                      ));
                    },
                  )
              ),
            ),
            Positioned(
                bottom: 200,
                right: 20,
                child: GestureDetector(
                  onTap: (){
                    fetchLocation();
                  },
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(100.0),),
                    ),
                    child: Icon(Icons.my_location,size: 20.0,color: blackColor,),
                  ),
                )
            ),
            Positioned(
                top: 60,
                right: 10,
                child: GestureDetector(
                  onTap: (){
                    _showBottomSheet();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white
                    ),
                    child: Icon(Icons.layers,color: blackColor,)
                  ),
                )
            ),
            Positioned(
                top: 60,
                left: 10,
                child: GestureDetector(
                  onTap: (){
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(100.0),),
                    ),
                    child: Icon(Icons.menu, color: blackColor,),
                  ),
                )
            ),
          ],
        ),
    );
  }
}
