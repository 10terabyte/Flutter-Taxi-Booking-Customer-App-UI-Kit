//import 'dart:async';
//import 'package:dio/dio.dart';
//import 'package:flutter/material.dart';
//import 'package:com_basoft_customer_ba/Model/place_model.dart';
//import 'package:com_basoft_customer_ba/config.dart';
//
//class PlaceBloc with ChangeNotifier {
//  StreamController<Place> locationController = StreamController<Place>.broadcast();
//  Place locationSelect;
//  List<Place> listPlace;
//
//  Stream get placeStream => locationController.stream;
//
//  Future<List<Place>> search(String query) async {
//    String url = "https://maps.googleapis.com/maps/api/place/textsearch/json?key=${Config.apiKey}&language=${Config.language}&region=${Config.region}&query=" +Uri.encodeQueryComponent(query);
//    Response response = await Dio().get(url);
//    print(Place.parseLocationList(response.data));
//    listPlace = Place.parseLocationList(response.data);
//    notifyListeners();
//    return listPlace;
//  }
//
//  void locationSelected(Place location) {
//    locationController.sink.add(location);
//  }
//
//  Future<void> setLocation(Place location) async {
//    notifyListeners();
//    locationSelect = location;
//    return locationSelect;
//  }
//
//
//  void dispose() {
//    locationController.close();
//  }
//}