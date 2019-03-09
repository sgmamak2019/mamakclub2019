import 'package:flutter/material.dart';
import 'package:mamakclub_beta/src/ui/mamakhome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget widgetForBody =
      HomePageLayout(title: 'petrol', collectionName: 'petrol');
  String title = "Petrol";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: HomePageLayout(title: 'Petrol', collectionName: 'petrol')
        //_buildScaffold(context)//HomePageLayout(title:'Petrol')
        );
  }
}
