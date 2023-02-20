import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../data/equatable.dart';

part 'get_routes_request_model.g.dart';

@JsonSerializable(nullable: true)
class GetRoutesRequestModel extends Equatable {
  @JsonKey(ignore: true)
  LatLng? fromLocation;
  @JsonKey(name: 'origin')
  String origin;

  @JsonKey(ignore: true)
  LatLng? toLocation;
  @JsonKey(name: 'destination')
  String destination;

  @JsonKey(name: 'mode')
  String mode;

  GetRoutesRequestModel({required this.fromLocation, required this.origin, required this.toLocation, required this.destination, this.mode = "driving"}) : super([origin, destination, mode]){
    if(origin == null && fromLocation != null){
      origin = "${fromLocation?.latitude},${fromLocation?.longitude}";
    }
    if(destination == null && toLocation != null){
      destination = "${toLocation?.latitude},${toLocation?.longitude}";
    }
    if(origin != null && fromLocation == null){
      final data = origin.split(',');
      if(data.length == 2) fromLocation = LatLng(double.parse(data[0]), double.parse(data[1]));
    }
    if(destination != null && toLocation == null){
      final data = destination.split(',');
      if(data.length == 2) toLocation = LatLng(double.parse(data[0]), double.parse(data[1]));
    }
  }

  factory GetRoutesRequestModel.fromJson(Map<String, dynamic> json) =>
      _$GetRoutesRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetRoutesRequestModelToJson(this);
}
