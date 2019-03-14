import 'package:flutter/material.dart';
import 'package:mamakclub_beta/mamakcommons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommoditiesRecord{
  List<Commodities> items;
}
class Commodities {
  final String commodity;
  final String commodity_desc;
  final String snap_nicedate;
  final String documentId;

  final DocumentReference reference;
  Commodities.fromMap(Map<String, dynamic> map, String docId, {this.reference})
      : commodity = MamakCommons.getValue(map["commodity"]),
        commodity_desc = MamakCommons.getValue(map["commodity_desc"]),
        snap_nicedate = MamakCommons.getValue(map["snap_nicedate"]),
        documentId = docId;

  Commodities.fromSnapShot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, snapshot.documentID, reference: snapshot.reference);

  @override
  String toString() => "";
}
