import 'dart:async';
import 'trafficcamprovider.dart';
import '../models/govpost.dart';
class Repository{
  final trafficProvider = TrafficCamProvider();
  Future<TrafficPost> fetchCams() => trafficProvider.fetchCams();
}