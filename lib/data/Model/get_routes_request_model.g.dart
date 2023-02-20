// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_routes_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRoutesRequestModel _$GetRoutesRequestModelFromJson(
    Map<String, dynamic> json) {
  return GetRoutesRequestModel(
      origin: json['origin'] as String,
      destination: json['destination'] as String,
      mode: json['mode'] as String, fromLocation: null, toLocation: null);
}

Map<String, dynamic> _$GetRoutesRequestModelToJson(
        GetRoutesRequestModel instance) =>
    <String, dynamic>{
      'origin': instance.origin,
      'destination': instance.destination,
      'mode': instance.mode
    };
