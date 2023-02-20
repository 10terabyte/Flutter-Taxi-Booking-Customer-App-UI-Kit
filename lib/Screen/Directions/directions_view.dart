import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_basoft_customer_ba/Blocs/place_bloc.dart';
import 'package:com_basoft_customer_ba/Components/autoRotationMarker.dart' as rm;
import 'package:com_basoft_customer_ba/Components/loading.dart';
import 'package:com_basoft_customer_ba/Screen/Directions/screens/chat_screen/chat_screen.dart';
import 'package:com_basoft_customer_ba/Screen/Directions/widgets/arriving_detail_widget.dart';
import 'package:com_basoft_customer_ba/Screen/Directions/widgets/booking_detail_widget.dart';
import 'package:com_basoft_customer_ba/app_router.dart';
import 'package:com_basoft_customer_ba/data/Model/direction_model.dart';
import 'package:com_basoft_customer_ba/theme/style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Networking/Apis.dart';
import '../../data/Model/direction_model.dart';
import '../../data/Model/get_routes_request_model.dart';
import '../../google_map_helper.dart';
import 'widgets/select_service_widget.dart';

class DirectionsView extends StatefulWidget {
  final PlaceBloc placeBloc;
  DirectionsView({required this.placeBloc});

  @override
  _DirectionsViewState createState() => _DirectionsViewState();
}

class _DirectionsViewState extends State<DirectionsView> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  List<LatLng> points = <LatLng>[];
  GoogleMapController? _mapController;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId? selectedMarker;
  BitmapDescriptor? markerIcon;

  Map<PolylineId, Polyline> polyLines = <PolylineId, Polyline>{};
  int _polylineIdCounter = 1;
  PolylineId? selectedPolyline;

  bool checkPlatform = Platform.isIOS;
  String? distance, duration;
  bool isLoading = false;
  bool isResult = false;
  LatLng? positionDriver;
  bool isComplete = false;
  var apis = Apis();
  List<Routes?>? routesData;
  final GMapViewHelper _gMapViewHelper = GMapViewHelper();
  PanelController panelController = PanelController();
  String? selectedService;

  void _onMapCreated(GoogleMapController controller) {
    this._mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    print(widget?.placeBloc?.formLocation);
    print(widget?.placeBloc?.locationSelect);
    addMakers();
    getRouter();
  }

  @override
  void dispose() {
    super.dispose();
  }

  addMakers(){
    checkPlatform ? print('ios'): print("adnroid");
    final MarkerId markerIdFrom = MarkerId("from_address");
    final MarkerId markerIdTo = MarkerId("to_address");

    final Marker marker = Marker(
      markerId: markerIdFrom,
      position: LatLng(widget?.placeBloc?.formLocation?.lat ?? 0, widget?.placeBloc?.formLocation?.lng ?? 0),
      infoWindow: InfoWindow(title: widget?.placeBloc?.formLocation?.name, snippet: widget?.placeBloc?.formLocation?.formattedAddress),
      // icon:  checkPlatform ? BitmapDescriptor.fromAsset("assets/image/marker/ic_dropoff_48.png") : BitmapDescriptor.fromAsset("assets/image/marker/ic_dropoff_96.png"),
      onTap: () {
      },
    );

    final Marker markerTo = Marker(
      markerId: markerIdTo,
      position: LatLng(widget?.placeBloc?.locationSelect?.lat ?? 0, widget?.placeBloc?.locationSelect?.lng ?? 0),
      infoWindow: InfoWindow(title: widget?.placeBloc?.locationSelect?.name, snippet: widget?.placeBloc?.locationSelect?.formattedAddress),
      // icon: checkPlatform ? BitmapDescriptor.fromAsset("assets/image/marker/ic_pick_48.png") : BitmapDescriptor.fromAsset("assets/image/marker/ic_pick_48.png"),
      onTap: () {
      },
    );

    setState(() {
      markers[markerIdFrom] = marker;
      markers[markerIdTo] = markerTo;
    });
  }

  ///Calculate and return the best router
  void getRouter() async {
    final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
    final PolylineId polylineId = PolylineId(polylineIdVal);
    polyLines.clear();
    var router;
    LatLng _fromLocation = LatLng(widget?.placeBloc?.formLocation?.lat ?? 0, widget?.placeBloc?.formLocation?.lng ?? 0);
    LatLng _toLocation = LatLng(widget?.placeBloc?.locationSelect?.lat ?? 0, widget?.placeBloc?.locationSelect?.lng ?? 0);

    await apis.getRoutes(
      getRoutesRequest: GetRoutesRequestModel(
          fromLocation: _fromLocation,
          toLocation: _toLocation,
          mode: "driving", origin: '', destination: ''
      ),
    ).then((data) {
      if (data != null) {
        router = data?.result?.routes?[0]?.overviewPolyline?.points;
        routesData = data?.result?.routes;
      }
    }).catchError((error) {
      print("GetRoutesRequest > $error");
    });

    distance = routesData?[0]?.legs?[0]?.distance?.text;
    duration = routesData?[0]?.legs?[0]?.duration?.text;

    polyLines[polylineId] = GMapViewHelper.createPolyline(
      polylineIdVal: polylineIdVal,
      router: router,
      formLocation: _fromLocation,
      toLocation: _toLocation,
    );
    setState(() {});
    _gMapViewHelper.cameraMove(fromLocation: _fromLocation,toLocation: _toLocation,mapController: _mapController!);
  }

  ///Real-time test of driver's location
  ///My data is demo.
  ///This function works by: every 5 or 2 seconds will request for api and after the data returns,
  ///the function will update the driver's position on the map.

  double? valueRotation;
  runTrackingDriver(var _listPosition){
    int count = 1;
    int two = count;
    const timeRequest = const Duration(seconds: 2);
    Timer.periodic(timeRequest, (Timer t) {
      LatLng positionDriverBefore = _listPosition[two-1];
      positionDriver = _listPosition[count++];
      print(count);

      valueRotation = rm.calculateangle(positionDriverBefore.latitude, positionDriverBefore.longitude,positionDriver?.latitude ?? 0 , positionDriver?.longitude ?? 0);
      print(valueRotation);
      addMakersDriver(positionDriver!);
      _mapController?.animateCamera(
        CameraUpdate?.newCameraPosition(
          CameraPosition(
            target: positionDriver!,
            zoom: 15.0,
          ),
        ),
      );
      if(count == _listPosition.length){
        setState(() {
          t.cancel();
          isComplete = true;
          showDialog(context: context, builder: dialogInfo());
        });

      }
    });
  }

  addMakersDriver(LatLng _position){
    final MarkerId markerDriver = MarkerId("driver");
    final Marker marker = Marker(
      markerId: markerDriver,
      position: _position,
      // icon: checkPlatform ? BitmapDescriptor.fromAsset("assets/image/icon_car_32.png") : BitmapDescriptor.fromAsset("assets/image/icon_car_120.png"),
      draggable: false,
      rotation: 0.0,
      consumeTapEvents: true,
      onTap: () {
        // _onMarkerTapped(markerId);
      },
    );
    setState(() {
      markers[markerDriver] = marker;
    });
  }

  dialogOption(){

    return AlertDialog(
      title: Text("Option"),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
      content: Container(
        child: TextFormField(
          style: textStyle,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            //border: InputBorder.none,
            hintText: "Ex: I'm standing in front of the bus stop...",
            // hideDivider: true
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Ok'),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),

      ],
    );
  }

  dialogPromoCode(){
    return AlertDialog(
      title: Text("Promo Code"),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      content: Container(
        child: TextFormField(
          style: textStyle,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            //border: InputBorder.none,
            hintText: "Enter promo code",
            // hideDivider: true
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Confirm'),
          onPressed: (){
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  handSubmit(){
    print("Submit");
    setState(() {
      isLoading = true;
    });
    Timer(Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
        isResult = true;
      });
    });
  }

  dialogInfo(){
    AlertDialog(
      title: Text("Information"),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
      content: Text('Trip completed. Review your trip now!.'),
      actions: <Widget>[
        TextButton(
          child: Text('Ok'),
          onPressed: (){
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(AppRoute.reviewTripScreen);
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        buildContent(context),
        Positioned(
          left: 18,
          top: 0,
          right: 0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
                leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(AppRoute.homeScreen);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white
                      ),
                      child: Icon(Icons.arrow_back_ios,color: blackColor,)
                    )
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildContent(BuildContext context){
    final screenSize = MediaQuery.of(context).size;
    print(selectedService);

    return SlidingUpPanel(
      controller: panelController,
      maxHeight: screenSize.height*0.8,
      minHeight: 0.0,
      parallaxEnabled: false,
      parallaxOffset: 0.8,
      backdropEnabled: false,
      renderPanelSheet: false,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      body: Stack(
        children: <Widget>[
          SizedBox(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              initialCameraPosition: CameraPosition(
                target: LatLng(widget?.placeBloc?.locationSelect?.lat ?? 0, widget?.placeBloc?.locationSelect?.lng ?? 0),
                zoom: 13,
              ),
              markers: Set<Marker>.of( markers.values),
              polylines: Set<Polyline>.of(polyLines.values),
            )
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Material(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )
              ),
              child: isLoading == true ?
              searchDriver(context):isResult == true ? ArrivingDetail(
                onTapCall: (){
                  launch('tel:+1 555 010 999');
                },
                onTapChat: (){
                  Navigator.of(context).push(MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return ChatScreen();
                      },
                      fullscreenDialog: true
                  ));
                },
                onTapCancel: (){
                  Navigator.of(context).pushNamed(AppRoute.cancellationReasonsScreen);
                },
              ) :
              BookingDetailWidget(
                bookingSubmit: handSubmit,
                panelController: panelController,
                distance: distance ?? '',
                duration: duration ?? '',
                onTapOptionMenu: () => showDialog(context: context, builder: dialogOption()),
                onTapPromoMenu: () => showDialog(context: context, builder: dialogPromoCode()),
              ),
            ),
          ),
        ],
      ),
      panel: SelectServiceWidget(
        serviceSelected: selectedService ?? '',
        panelController: panelController,
      ),
    );
  }

  Widget searchDriver(BuildContext context){
    return Container(
        height: 270.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: LoadingBuilder(),
            ),
            SizedBox(height: 20),
            Text('Searching for a driver',
              style: TextStyle(
                fontSize: 18,
                color: greyColor,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        )
    );
  }
}
