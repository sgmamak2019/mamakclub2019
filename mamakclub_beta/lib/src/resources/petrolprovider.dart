import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mamakclub_beta/src/models/petrolmodel.dart';

class PetrolProvider{
  Future<List<Petrol>> fetchAllPetrol() async{
     //final  resp = await Firestore.instance.collection(collection).getDocuments();
     final resp = await Firestore.instance.collection('petrol').getDocuments();
     return toList(resp.documents);
  }
  
  List<Petrol> toList(List<DocumentSnapshot> snap) {
    List<Petrol> petrolList = new List<Petrol>();
    snap.forEach((x)=>{
        petrolList.add(Petrol.fromSnapShot(x))
    });
    return petrolList;
  }
}