import 'package:flutter/material.dart';
import 'package:mamakclub_beta/mamakhome.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: HomePageLayout(title:'Petrol')
    );
  }
}
