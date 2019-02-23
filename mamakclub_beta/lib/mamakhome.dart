import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mamakclub_beta/mamakstyles.dart';
import 'package:mamakclub_beta/collection.dart';
import 'package:mamakclub_beta/petrolrecord.dart';

class HomePageLayoutState extends State<HomePageLayout> {
  String currentCollection = "petrol";
  Widget currentWidget = Text('Tt');
  String currentTitle = "Petrol";
  List<Collection> collections;

  void initCollections() {
    Collection petrol = new Collection();
    Collection fxsg = new Collection();
    Collection fxmy = new Collection();
    Collection fixed_sg = new Collection();
    Collection fixed_my = new Collection();
    petrol.collectionName = "petrol";
    petrol.titleName = "Petrol";
    fxsg.collectionName = "fx";
    fxsg.collectionIcon = Icons.attach_money;
    fxsg.titleName = "FX (SG)";
    fxmy.titleName = "FX (MY)";
    fxmy.collectionIcon = Icons.attach_money;
    fxmy.collectionName = "fx_my";
    fixed_sg.collectionName = "fixed_deposit_sg";
    fixed_sg.collectionIcon = Icons.account_balance;
    fixed_sg.titleName = "Fixed Deposit SG";
    fixed_my.collectionIcon = Icons.account_balance;
    fixed_my.collectionName = "fixed_deposit_my";
    fixed_my.titleName = "Fixed Deposit MY";
    petrol.collectionIcon = Icons.airport_shuttle;
    collections = new List<Collection>();
    collections.add(petrol);
    collections.add(fxsg);
    collections.add(fxmy);
    collections.add(fixed_sg);
    collections.add(fixed_my);
  }

  Widget _buildFirstLine(DocumentSnapshot snapshot) {
    Record datax = Record.fromSnapShot(snapshot);
    return new Align(
        alignment: Alignment.center,
        child: Text('Prices snapped at : ' + datax.snap_nicedate,
            style: MamakStyles.headerFooterSmallStyle()));
  }

  Widget _buildInfo(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .document(currentCollection + '/_info')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildFirstLine(snapshot.data);
        });
  }

  Widget _buildBody(String collectionName) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection(currentCollection).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data.documents);
        });
  }

  Widget drawListItem(Collection collectionData, BuildContext ctx,IconData icon) {
    return new ListTile(
        title: Text(collectionData.titleName),
        leading: Icon(icon),
        onTap: () {
          setState(() {
            this.currentCollection = collectionData.collectionName;
            this.currentTitle = collectionData.titleName;
            this.currentWidget = _buildBody(collectionData.collectionName);
            Navigator.of(ctx).pop();
          });
        });
  }

  Widget _drawerList(BuildContext ctx) {
    List<Widget> drawL = new List<Widget>();
    drawL.add(
      new Container(
        height: 100,
        child: DrawerHeader(
          child: Column(children: [
            Text(
              'Mamak Club',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )
          ]),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
    this.collections.forEach((c) => drawL.add(drawListItem(c, ctx,c.collectionIcon)));
    return new ListView(padding: EdgeInsets.zero, children: drawL);
  }

  Widget _buildScaffold(BuildContext ctx) {
    return new Scaffold(
        drawer: new Drawer(child: _drawerList(ctx)),
        appBar: AppBar(title: Text(currentTitle)),
        body: _buildBody(currentCollection)
        //_buildBody(context)
        );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Widget> forBuilding = new List<Widget>();
    forBuilding.add(_buildInfo(context));
    forBuilding
        .addAll(snapshot.map((data) => _buildListItem(context, data)).toList());

    return ListView(
        padding: const EdgeInsets.only(top: 20.0), children: forBuilding);
  }

  Widget _buildExpansionTable(Record r) {
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
                TableCell(child: _buildMamakCell('With Discount')),
                TableCell(
                    child: _buildMamakCellWithSub(r.price_with_discount,
                        r.price_with_discount_company, Colors.green))
              ]),
          TableRow(
              decoration: BoxDecoration(border: Border.all(width: 0.0)),
              children: [
                TableCell(child: _buildMamakCell('No Discount')),
                TableCell(
                    child: _buildMamakCellWithSub(r.price_no_discount,
                        r.price_no_discount_company, Colors.red))
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
    final Record record = Record.fromSnapShot(data);
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

  @override
  Widget build(BuildContext context) {
    initCollections();
    return _buildScaffold(context);
  }
}

class HomePageLayout extends StatefulWidget {
  final String title;
  final String collectionName;

  HomePageLayout({Key key, @required this.title, @required this.collectionName})
      : super(key: key);

  @override
  HomePageLayoutState createState() => new HomePageLayoutState();
}

