import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mamakclub_beta/src/models/fxmodel.dart';

class FXProvider {
  Future<List<FX>> fetchFXData(String collection) async {
    final  resp = await Firestore.instance.collection(collection).getDocuments();
    return toList(resp.documents);
 }

  List<FX> toList(List<DocumentSnapshot> snap) {
    List<FX> fxList = new List<FX>();
  
    snap.forEach((x)=>fxList.add(FX.fromSnapShot(x)));
    return fxList;
  }
}
