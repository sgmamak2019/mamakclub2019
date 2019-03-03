import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mamakclub_beta/mamakstyles.dart';
import 'package:mamakclub_beta/petrolmodel.dart';
import 'package:mamakclub_beta/mamakcard.dart';

class PetrolAdvisorLayoutState extends State<PetrolAdvisorLayout> {
  Widget _buildColumnCard(BuildContext context, DocumentSnapshot data) {
    final Petrol record = Petrol.fromSnapShot(data);
    if (data.documentID == '_info') {
      return new Divider();
    }
    return new MamakCard(
        cardTitle: data.documentID,
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

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Widget> forBuilding = new List<Widget>();
    forBuilding.add(_buildInfo(context));
    forBuilding.addAll(
        snapshot.map((data) => _buildColumnCard(context, data)).toList());
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: forBuilding,
    );
  }

  Widget _buildBody(String collectionName) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection(collectionName).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data.documents);
        });
  }

  @override
  Widget build(BuildContext ctx) {
    return _buildBody(widget.collectionName);
  }
}

class PetrolAdvisorLayout extends StatefulWidget {
  final String collectionName = "petrol";

  @override
  PetrolAdvisorLayoutState createState() => new PetrolAdvisorLayoutState();
}
