// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'googleMap_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GMapMessage _$GMapMessageFromJson(Map<String, dynamic> json) {
  return GMapMessage(
      geocodedWaypoints: (json['geocoded_waypoints'] as List)
          ?.map((e) => e == null
              ? null
              : GeocodedWaypoint.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      routes: (json['routes'] as List)
          ?.map((e) =>
              e == null ? null : Routes.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      errorMessage: json['error_message'] as String,
      statusCode: json['status'] as String);
}

Map<String, dynamic> _$GMapMessageToJson(GMapMessage instance) =>
    <String, dynamic>{
      'geocoded_waypoints': instance.geocodedWaypoints,
      'routes': instance.routes,
      'error_message': instance.errorMessage,
      'status': instance.statusCode
    };
