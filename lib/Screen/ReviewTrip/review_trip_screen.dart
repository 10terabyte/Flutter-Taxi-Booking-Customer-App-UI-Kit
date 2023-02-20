import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:com_basoft_customer_ba/Components/ink_well_custom.dart';
import 'package:com_basoft_customer_ba/theme/style.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../app_router.dart';

class ReviewTripScreen extends StatefulWidget {
  @override
  _ReviewTripScreenState createState() => _ReviewTripScreenState();
}

class _ReviewTripScreenState extends State<ReviewTripScreen> {
  GoogleMapController? googleMapController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LatLng currentLocation = LatLng(39.065747, -95.630775);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId? selectedMarker;
  Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};
//  int _polylineIdCounter = 1;
  PolylineId? selectedPolyline;
  double? ratingScore;

  void _onMapCreated(GoogleMapController controller) {
    this.googleMapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        //iconTheme: IconThemeData(color: blackColor),
        elevation: 0.0,
        backgroundColor: whiteColor,
        title: Text('Review your trip',style: TextStyle(color: blackColor),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.of(context).pushReplacementNamed(AppRoute.homeScreen);
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
        child: ButtonTheme(
          minWidth: screenSize.width,
          height: 50.0,
          child: TextButton(
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            // elevation: 0.0,
            // color: primaryColor,
            child: Text('Submit Review',style: headingWhite,
            ),
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(AppRoute.homeScreen);
            },
          ),
        ),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowGlow();
          return false;
        },
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Container(height: screenSize.height*0.35),
                    Container(
                      height: screenSize.height*0.25,
                      child: mapView(context),
                    ),
                    Positioned(
                      top: screenSize.height*0.18,
                      child: Material(
                        elevation: 10.0,
                        color: Colors.white,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Hero(
                              tag: "avatar_profile",
                              child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: CachedNetworkImageProvider(
                                    "https://source.unsplash.com/300x300/?portrait",
                                  )
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                InkWellCustom(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: buildContent(context)
                ),

              ],
            ),
          ),
        ),
      )
    );
  }

  Widget mapView(BuildContext context){
    return SizedBox(
        height: 215.0,
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          initialCameraPosition: CameraPosition(
            target: LatLng(currentLocation.latitude, currentLocation.longitude),
            zoom: 11,
          ),
          markers: Set<Marker>.of(markers.values),
          polylines: Set<Polyline>.of(polylines.values),
        )
    );
  }

  Widget buildContent(BuildContext context){
    return Column(
      children: <Widget>[
        Text("John Wick",
          style: TextStyle(
            fontSize: 14,
            color: blackColor,
            fontWeight: FontWeight.w500
          ),
        ),
        Text("Huyndai(TX32-33567)",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 10),
        // RatingBar(
        //   initialRating: 4,
        //   allowHalfRating: true,
        //   itemSize: 30.0,
        //   glowColor: whiteColor,
        //   itemBuilder: (context, _) => Icon(
        //     Icons.star,
        //     color: Colors.amber,
        //   ),
        //   onRatingUpdate: (rating) {
        //     ratingScore = rating;
        //     print(rating);
        //   },
        // ),
        SizedBox(height: 10),
        Text("How is your trips?",
          style: TextStyle(
              fontSize: 16,
              color: blackColor,
              fontWeight: FontWeight.bold
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 5.0,),
        Text("You feedback will help improve driving experience",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        Container(
          padding: EdgeInsets.only(top: 15.0,left: 20, right: 20),
          child: SizedBox(
            height: 100.0,
            child: TextField(
              style: TextStyle(
                color: Colors.black38,
                fontSize: 14.0,
              ),
              decoration: InputDecoration(
                hintText: "Additional comments...",
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: 14.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderRadius:BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
                ),
              ),
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              onChanged: (String value) {
              },
            ),
          ),
        ),
      ],
    );
  }
}
