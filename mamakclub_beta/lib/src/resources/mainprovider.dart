import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mamakclub_beta/src/models/commoditiesmodel.dart';

class MainProvider {
  Future<List<Commodities>> fetch() async {
    final resp = await Firestore.instance.collection('mamak_commodities').getDocuments();
    return toList(resp.documents);
  }

  List<Commodities> toList(List<DocumentSnapshot> snap) {
    List<Commodities> comList = new List<Commodities>();
    snap.forEach((x) => comList.add(Commodities.fromSnapShot(x)));
    return comList;
  }
 
}
