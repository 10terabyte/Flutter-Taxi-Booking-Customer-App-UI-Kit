import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'json_message.dart';
import '../data/Model/direction_model.dart';

part 'googleMap_message.g.dart';

GMapMessage gMapMessageFromJson(String str) => GMapMessage.fromJson(json.decode(str));

String gMapMessageToJson(GMapMessage data) => json.encode(data.toJson());

@JsonSerializable(nullable: true)
class GMapMessage extends JsonMessage {
  @JsonKey(name: 'geocoded_waypoints')
  final List<GeocodedWaypoint?>? geocodedWaypoints;
  @JsonKey(name: 'routes')
  final List<Routes?>? routes;
  @JsonKey(name: 'error_message')
  final String errorMessage;
  @JsonKey(name: 'status')
  final String? statusCode;

  @JsonKey(ignore: true)
  final ResultData data;

  GMapMessage({
     this.geocodedWaypoints,
     this.routes,
     required this.errorMessage,
     this.statusCode,
  }) : data = ResultData(geocodedWaypoints: geocodedWaypoints, routes: routes,);

  factory GMapMessage.fromJson(Map<String, dynamic> json) =>
      _$GMapMessageFromJson(json);

  Map<String, dynamic> toJson() => _$GMapMessageToJson(this);

  @override
  String get errorCode => statusCode! == "OK" ? '' : statusCode!;

  @override
  ResultData get result => data;

  @override
  int get status => statusCode == "OK" ? 200 : (statusCode == "REQUEST_DENIED" ? 401 : 500);
}
