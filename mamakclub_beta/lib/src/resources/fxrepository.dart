import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mamakclub_beta/src/models/fxmodel.dart';
import 'package:mamakclub_beta/src/resources/fxprovider.dart';

class FXRepository {
  final FXProvider fxProvider = FXProvider();
  Future<List<FX>> fetchFX(String s) => fxProvider.fetchFXData(s);
  
}
