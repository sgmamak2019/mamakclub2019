import 'dart:async';
import 'package:mamakclub_beta/src/models/commoditiesmodel.dart';
import 'package:mamakclub_beta/src/resources/mainprovider.dart';

class MainRepository {
  final MainProvider mainProvider = MainProvider();
  Future<List<Commodities>> fetchComms() => mainProvider.fetch(); 
  
}
