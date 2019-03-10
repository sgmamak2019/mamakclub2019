import 'package:flutter/material.dart';
import 'package:mamakclub_beta/src/ui/petroladvisor.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: PetrolAdvisorLayout(collectionName: 'petrol',)
        );
  }
}
