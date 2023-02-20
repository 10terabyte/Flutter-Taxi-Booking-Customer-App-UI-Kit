// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultData _$ResultDataFromJson(Map<String, dynamic> json) {
  return ResultData(
      geocodedWaypoints: (json['geocoded_waypoints'] as List)
          ?.map((e) => e == null
              ? null
              : GeocodedWaypoint.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      routes: (json['routes'] as List)
          ?.map((e) =>
              e == null ? null : Routes.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ResultDataToJson(ResultData instance) =>
    <String, dynamic>{
      'geocoded_waypoints': instance.geocodedWaypoints,
      'routes': instance.routes
    };
