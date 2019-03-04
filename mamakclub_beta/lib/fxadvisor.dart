import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mamakclub_beta/mamakstyles.dart';
import 'package:mamakclub_beta/fxmodel.dart';
import 'package:mamakclub_beta/mamakcard.dart';

class FXAdvisorLayoutState extends State<FXAdvisorLayout> {
 
  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final FX record = FX.fromSnapShot(data);
    if (data.documentID == "_info") {
      return new Divider();
    }
    return new MamakCard(
        cardTitle: data.documentID,
        leftHeader: 'BUY',
        rightHeader: 'SELL',
        leftValue: record.buy_tt,
        rightValue: record.sell_tt,
        leftSubTitle: record.buy_tt_company,
        rightSubTitle: record.sell_tt_company);
  }

  Widget _buildFirstLine(DocumentSnapshot snapshot) {
    FX datax = FX.fromSnapShot(snapshot);
    return new Align(
        alignment: Alignment.center,
        child: Text('Prices snapped at : ' + datax.snap_nice_date,
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
    forBuilding
        .addAll(snapshot.map((data) => _buildListItem(context, data)).toList());

    return ListView(
        padding: const EdgeInsets.only(top: 20.0), children: forBuilding);
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

class FXAdvisorLayout extends StatefulWidget {
  final String collectionName;

  FXAdvisorLayout({Key key, @required this.collectionName}) : super(key: key);

  @override
  FXAdvisorLayoutState createState() => new FXAdvisorLayoutState();
}
