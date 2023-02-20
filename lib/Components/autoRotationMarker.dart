//import 'dart:math' show pi;
import 'package:latlong/latlong.dart';


  double calculateangle(double lat1,double lon1,double lat2,double lon2){

    final Distance distance = const Distance();
//    final num distanceInMeter = (EARTH_RADIUS * pi / 4).round();

    final p1 = LatLng(lat1, lon1);
    final p2 = LatLng(lat2, lon2);

    return distance.bearing(p1, p2);

  }
