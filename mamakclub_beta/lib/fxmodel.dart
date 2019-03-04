import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mamakclub_beta/mamakcommons.dart';

class FX {
  final String unit;
  final String sell_tt_company;
  final String sell_tt;
  final String buy_tt_company;
  final String buy_tt;
  final String snap_nice_date;
  final String buy_notes;
  final String sell_notes;
  final String buy_notes_company;
  final String sell_notes_company;
  final DocumentReference reference;

  FX.fromMap(Map<String, dynamic> map, {this.reference})
      : unit = MamakCommons.getValue(map['unit']),
        sell_notes = MamakCommons.getValue(map['sell_notes']),
        sell_notes_company = MamakCommons.getValue(map['sell_notes_company']),
        buy_notes = MamakCommons.getValue(map['buy_notes']),
        buy_notes_company = MamakCommons.getValue(map['buy_notes_company']),
        buy_tt = MamakCommons.getValue(map['buy_tt']),
        buy_tt_company = MamakCommons.getValue(map['buy_tt_company']),
        sell_tt = MamakCommons.getValue(map['sell_tt']),
        sell_tt_company = MamakCommons.getValue(map['sell_tt_company']),
        snap_nice_date = MamakCommons.getValue(map['snap_nicedate']);

  FX.fromSnapShot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$sell_tt_company:$buy_tt_company>";
}
