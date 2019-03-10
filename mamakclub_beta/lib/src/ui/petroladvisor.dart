import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mamakclub_beta/src/ui/mamakstyles.dart';
import 'package:mamakclub_beta/src/models/petrolmodel.dart';
import 'package:mamakclub_beta/src/ui/mamakcard.dart';
import 'package:mamakclub_beta/src/blocs/petrolbloc.dart';
import 'package:mamakclub_beta/mamakcommons.dart';
class PetrolAdvisorLayoutState extends State<PetrolAdvisorLayout> {
  MamakCommons mamakCommons = MamakCommons();

  Widget _buildColumnCard(BuildContext context, Petrol data) {
    final Petrol record =data;
    
    return new MamakCard(
        cardTitle: record.documentId,
        leftHeader: 'with Discount',
        rightHeader: 'No Discount',
        leftValue: record.price_with_discount,
        rightValue: record.price_no_discount,
        leftSubTitle: record.price_with_discount_company,
        rightSubTitle: record.price_no_discount_company);
  }
  Widget _buildFirstLine(DocumentSnapshot snapshot) {
    Petrol datax = Petrol.fromSnapShot(snapshot);
    return new Align(
        alignment: Alignment.center,
        child: Text('Prices snapped at : ' + datax.snap_nicedate,
            style: MamakStyles.headerFooterSmallStyle()));
  }

  Widget _buildInfo(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .document(widget.collectionName + '/_info')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildFirstLine(snapshot.data);
        });
  }

  Widget _buildList(List<Petrol> snapshot) {
    List<Widget> forBuilding = new List<Widget>();
    forBuilding.add(_buildInfo(context));
    forBuilding.addAll(
        snapshot.map((data) => _buildColumnCard(context,data)).toList());
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: forBuilding,
    );
  }

  Widget _buildBody(String collectionName) {
    petrolBloc.fetchAllPetrol();
       return new Container(
        child:StreamBuilder(
          stream:petrolBloc.allPetrol,
          builder:(context,AsyncSnapshot<PetrolRecord> snapshot){
            if (snapshot.hasData) {
                return _buildList(snapshot.data.items);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
               return Center(child:CircularProgressIndicator());
          }
        )
       );
  }

  @override
  Widget build(BuildContext ctx) {
   return Scaffold(
        drawer: mamakCommons.getMamakDrawer(ctx),
        appBar: AppBar(
          title: Text('Petrol'),
        ),
        body: _buildBody("petrol")
      );
  }
}
class PetrolAdvisorLayout extends StatefulWidget {
  String collectionName = "petrol";
  PetrolAdvisorLayout({Key key, @required this.collectionName}):super(key:key);
 @override
  PetrolAdvisorLayoutState createState() => new PetrolAdvisorLayoutState();
}
