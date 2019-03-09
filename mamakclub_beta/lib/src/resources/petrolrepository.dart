import 'dart:async';
import 'package:mamakclub_beta/src/models/petrolmodel.dart';
import 'package:mamakclub_beta/src/resources/petrolprovider.dart';

class PetrolRepository{
  //1. instance of provider
  final PetrolProvider petrolProvider = new PetrolProvider();
  //2. create method to extract Petrol Listing (use the petrolProvider)
  Future<List<Petrol>> fetchAllPetrol() => petrolProvider.fetchAllPetrol();
  //3. create a BLoC for this. on /src/blocs

}