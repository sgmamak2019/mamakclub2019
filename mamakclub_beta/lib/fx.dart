import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mamakclub_beta/mamakstyles.dart';
import 'package:mamakclub_beta/fxmodel.dart';

class FXLayoutState extends State<FXLayout> {
    
  Widget _buildExpansionTable(FX r) {
    return new Container(
        child: Table(
            border: TableBorder(
                left: BorderSide.none,
                top: BorderSide.none,
                bottom: BorderSide.none),
            children: [
          TableRow(
              decoration: BoxDecoration(border: Border.all(width: 0.0)),
              children: [
                TableCell(
                    child: new Align(
                        alignment: Alignment.centerLeft, child: new Text(''))),
                TableCell(
                    child: new Container(
                        width: 10,
                        child: new Align(
                            alignment: Alignment.center,
                            child: new Text('PRICES',
                                style: MamakStyles.tableHeaderStyle()))))
              ]),
          TableRow(
              decoration: BoxDecoration(
                  color: Colors.grey[300], border: Border.all(width: 0.0)),
              children: [
                TableCell(child: _buildMamakCell('Buy')),
                TableCell(
                    child: _buildMamakCellWithSub(r.buy_tt,
                        r.buy_tt_company, Colors.green))
              ]),
          TableRow(
              decoration: BoxDecoration(border: Border.all(width: 0.0)),
              children: [
                TableCell(child: _buildMamakCell('Sell')),
                TableCell(
                    child: _buildMamakCellWithSub(r.sell_tt,
                        r.sell_tt_company, Colors.red))
              ])
        ]));
  }

  Widget _buildMamakCell(String label) {
    return new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          new Padding(
              padding: EdgeInsets.all(5.0),
              child: Align(
                  alignment: Alignment.topCenter,
                  child:
                      new Text(label, style: MamakStyles.tableHeaderStyle())))
        ]);
  }

  Widget _buildMamakCellWithSub(
      String title, String subtitle, MaterialColor titleColor) {
    return new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          new Padding(
            padding: EdgeInsets.only(top: 3.0, bottom: 3),
            child: new Align(
                alignment: Alignment.center,
                child: new Text(title,
                    style: MamakStyles.paddingTitleStyle(titleColor))),
          ),
          new Padding(
            padding: EdgeInsets.all(0.5),
            child: new Align(
                alignment: Alignment.center,
                child: new Text(subtitle,
                    style: MamakStyles.paddingSubTitleStyle())),
          ),
        ]);
  }


    Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final FX record = FX.fromSnapShot(data);
    if (data.documentID == "_info") {
      return new Divider();
    }
    return new Container(
        decoration: new BoxDecoration(
            border: new Border(
                bottom: new BorderSide(
                    color: Colors.blue, style: BorderStyle.none))),
        child: new Column(children: [
          ExpansionTile(
            initiallyExpanded: true,
            title: new Container(
                height: 10,
                padding: EdgeInsets.all(0.0),
                child: new Align(
                    child: new Text(data.documentID,
                        style: MamakStyles.expansionTitleStyle()))),
            children: <Widget>[_buildExpansionTable(record)],
          )
        ]));
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
class FXLayout extends StatefulWidget {
  final String collectionName;

  
  FXLayout({Key key,  @required this.collectionName})
      : super(key: key);

  @override
  FXLayoutState createState() => new FXLayoutState();
}
