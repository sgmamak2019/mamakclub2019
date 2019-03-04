
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mamakclub_beta/mamakcommons.dart';
class Petrol {
  final String price_no_discount;
  final String price_no_discount_company;
  final String price_with_discount;
  final String price_with_discount_company;
  final String snap_nicedate;
  final DocumentReference reference;

  Petrol.fromMap(Map<String, dynamic> map, {this.reference})
      : price_no_discount = MamakCommons.getValue( map['price-no-discount']),
        price_no_discount_company = MamakCommons.getValue(map['price-no-discount_company']),
        price_with_discount = MamakCommons.getValue(map['price-with-discount']),
        price_with_discount_company = MamakCommons.getValue(map['price-with-discount_company']),
        snap_nicedate = MamakCommons.getValue(map['snap_nicedate']);
             
  Petrol.fromSnapShot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$price_no_discount:$price_no_discount_company>";
}
