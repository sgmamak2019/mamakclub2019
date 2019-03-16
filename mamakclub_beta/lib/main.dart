import 'package:flutter/material.dart';
import 'package:mamakclub_beta/src/ui/petroladvisor.dart';
import 'package:mamakclub_beta/src/blocs/mainbloc.dart';
import 'package:mamakclub_beta/src/models/commoditiesmodel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 
  Widget getBuilder(){
     mainBloc.fetchAllCommodities();
    return StreamBuilder(
            stream: mainBloc.allComms ,
            builder: (context, AsyncSnapshot<List<Commodities>> snapshot) {
              if (snapshot.hasData) {
                return PetrolAdvisorLayout(collectionName: 'petrol',snap_nicedate:snapshot.data.first.snap_nicedate);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(child: CircularProgressIndicator());
            });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: getBuilder()
        //home:FXAdvisorLayoutMY(collectionName: 'fx',snap_nicedate: ,)
        );
  }
}
