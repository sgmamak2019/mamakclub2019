import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mamakclub_beta/src/ui/mamakstyles.dart';
import 'package:mamakclub_beta/src/models/fxmodel.dart';
import 'package:mamakclub_beta/src/ui/mamakcard.dart';
import 'package:mamakclub_beta/mamakcommons.dart';
import 'package:mamakclub_beta/src/blocs/fxbloc.dart';

class FXAdvisorLayoutMYState extends State<FXAdvisorLayoutMY> {

  MamakCommons mamakCommons = MamakCommons();
  void showBottomModal(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (ctx) {
          return Container(
              color: Colors.white10,
              height: 400.0,
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(30.0),
                          topRight: const Radius.circular(10))),
                  child: TextField(
                    autofocus: true,
                    onChanged: (text) {
                      fxBloc.currentFilter = text;
                      fxBloc.fetchAllMYFXFilter(fxBloc.currentFilter);
                    },
                  )));
        });
  }

  Widget _buildListItem(FX data, String mode) {
    final FX record = data;

    if (mode != 'NOTES') {
      return new MamakCard(
          cardTitle: record.documentId,
          leftHeader: 'BUY',
          rightHeader: 'SELL',
          leftValue: record.buy_tt,
          rightValue: record.sell_tt,
          leftSubTitle: record.buy_tt_company,
          rightSubTitle: record.sell_tt_company);
    } else {
      return new MamakCard(
          cardTitle: record.documentId,
          leftHeader: 'BUY',
          rightHeader: 'SELL',
          leftValue: record.buy_notes,
          rightValue: record.sell_notes,
          leftSubTitle: record.buy_notes_company,
          rightSubTitle: record.sell_notes_company);
    }
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

  Widget _buildList(List<FX> snapshot, String mode) {
    List<Widget> forBuilding = new List<Widget>();
    if (fxBloc.currentFilter != "") {
      forBuilding.add(
        FlatButton(
          onPressed: () {
            fxBloc.currentFilter = "";
            fxBloc.fetchAllMYFXFilter(fxBloc.currentFilter);
          },
          color: Colors.blueGrey,
          padding: EdgeInsets.all(10.0),
          child: Column(
            // Replace with a Row for horizontal icon + text
            children: <Widget>[
              Text("Clear Filter: " + fxBloc.currentFilter,
                  style: TextStyle(color: Colors.white))
            ],
          ),
        ),
      );
    }
    forBuilding.add(_buildInfo(context));

    forBuilding
        .addAll(snapshot.map((data) => _buildListItem(data, mode)).toList());

    return ListView(
        padding: const EdgeInsets.only(top: 20.0), children: forBuilding);
  }

  Widget _buildBody(String collectionName, String mode) {
    if (fxBloc.currentFilter == "") {
      fxBloc.fetchAllMYFX();
    }
    return new Container(
        child: StreamBuilder(
            stream: fxBloc.allMYFx,
            builder: (context, AsyncSnapshot<FXRecord> snapshot) {
              if (snapshot.hasData) {
                return _buildList(snapshot.data.items, mode);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

  void refresh() {
    fxBloc.fetchAllMYFX();
  }

  @override
  Widget build(BuildContext ctx) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: mamakCommons.getMamakDrawer(ctx),
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                tooltip: 'Search',
                onPressed: (() {
                  this.showBottomModal(ctx);
                }))
          ],
          bottom: TabBar(
            tabs: [Text('TT'), Text('NOTES')],
            onTap: (x) {
              setState(() {
                fxBloc.currentFilter="";
                this.refresh();
              });
            },
          ),
          title: Text('FX (MY)'),
        ),
        body: TabBarView(
          children: [
            _buildBody('fx_my', "TT"),
            _buildBody('fx_my', "NOTES"),
          ],
        ),
      ),
    );
  }
}

class FXAdvisorLayoutMY extends StatefulWidget {
  final String collectionName;

  FXAdvisorLayoutMY({Key key, @required this.collectionName}) : super(key: key);
  
  @override
  FXAdvisorLayoutMYState createState(){
    fxBloc.currentFilter="";
    return new FXAdvisorLayoutMYState();
  } 
}
