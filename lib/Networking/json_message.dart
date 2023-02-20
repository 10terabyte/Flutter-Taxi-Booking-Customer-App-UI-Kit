import '../data/Model/direction_model.dart';
import '../data/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_message.g.dart';

abstract class JsonMessage {
  int get status;

  String get errorCode;

  String get errorMessage;

  ResultData? get result;
}

class SuccessMessage extends JsonMessage {
  int get status => 200;

  String get errorCode => '';

  String get errorMessage => '';

  ResultData? get result => null;
}

@JsonSerializable(nullable: true)
class ResultData extends Equatable {
  ResultData({
    this.geocodedWaypoints,
    this.routes,
  }) : super([geocodedWaypoints, routes,]);

  @JsonKey(name: 'geocoded_waypoints')
  List<GeocodedWaypoint?>? geocodedWaypoints;

  @JsonKey(name: 'routes')
  List<Routes?>? routes;

  factory ResultData.fromJson(Map<String, dynamic> json) =>
      _$ResultDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResultDataToJson(this);
}
