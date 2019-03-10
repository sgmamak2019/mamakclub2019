
import 'package:cloud_firestore/cloud_firestore.dart';
class FixedDeposit {
  final String unit;
  final String sell_tt_company;
  final String sell_tt;
  final String buy_tt_company;
  final String buy_tt;
  final String snap_nice_date;

  final DocumentReference reference;

  FixedDeposit.fromMap(Map<String, dynamic> map, {this.reference})
      : unit =
            map['unit'] == null ? '' : map['unit'],
        sell_tt_company = map['sell_tt_company'] == null
            ? ''
            : map['sell_tt_company'],
        sell_tt = map['sell_tt'] == null
            ? ''
            : map['sell_tt'],
        buy_tt_company = map['buy_tt_company'] == null
            ? ''
            : map['buy_tt_company'],
        buy_tt =
            map['buy_tt'] == null ? '' : map['buy_tt'],
        snap_nice_date = map['snap_nicedate'] == null ? '' : map['snap_nicedate'];

  FixedDeposit.fromSnapShot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$sell_tt_company:$buy_tt_company>";
}
