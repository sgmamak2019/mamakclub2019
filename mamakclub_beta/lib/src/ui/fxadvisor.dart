import 'package:flutter/material.dart';

import 'package:mamakclub_beta/src/models/fxmodel.dart';
import 'package:mamakclub_beta/src/ui/mamakcard.dart';
import 'package:mamakclub_beta/src/blocs/fxbloc.dart';
import 'package:mamakclub_beta/mamakcommons.dart';

class FXAdvisorLayoutState extends State<FXAdvisorLayout> {
  MamakCommons mamakCommons = MamakCommons();
  String currentFilter="";  
  //line below creates a variable which we will use to hold the instance of our scaffold

  Widget _buildListItem(BuildContext context, FX data) {
    return new MamakCard(
        cardTitle: data.documentId,
        leftHeader: 'BUY',
        rightHeader: 'SELL',
        leftValue: data.buy_tt,
        rightValue: data.sell_tt,
        leftSubTitle: data.buy_tt_company,
        rightSubTitle: data.sell_tt_company);
  }

  Widget _buildList(List<FX> snapshot) {
    List<Widget> forBuilding = new List<Widget>();
    if (fxBloc.currentFilter != "") {
      forBuilding.add(
            FlatButton(
                onPressed: () {
                  fxBloc.currentFilter = "";
                 fxBloc.fetchAllSGFX();
                },
                color: Colors.blueGrey,
                padding: EdgeInsets.all(10.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Text("Clear Filter: " + fxBloc.currentFilter,style:TextStyle(color:Colors.white) )
                  ],
                ),
              ),
      );
    }
    //forBuilding.add(_buildInfo(context));
    forBuilding
        .addAll(snapshot.map((data) => _buildListItem(context, data)).toList());
    //if filter is in effect, add a button for clearing

    return ListView(
        padding: const EdgeInsets.only(top: 20.0), children: forBuilding);
  }

  Widget _buildBody(BuildContext context, String collectionName) {
    if (fxBloc.currentFilter == "") {
      //if filter is in place, do not make a call to firestore.
      fxBloc.fetchAllSGFX();
    }
    return new Container(
        child: StreamBuilder(
            stream: fxBloc.allSGFx,
            builder: (context, AsyncSnapshot<FXRecord> snapshot) {
              if (snapshot.hasData) {
                return _buildList(snapshot.data.items);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

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
                      fxBloc.fetchAllSGFXFilter(fxBloc.currentFilter);
                 
                    },
                  )));
        });
  }
  @override
  Widget build(BuildContext ctx) {
    // return _buildBody(ctx, widget.collectionName);
    return Scaffold(
        drawer: mamakCommons.getMamakDrawer(ctx),
        appBar: AppBar(title: Text('FX [SG]'), actions: [
          IconButton(
              icon: Icon(Icons.search),
              tooltip: 'Search',
              onPressed: (() {
                this.showBottomModal(ctx);
              }))
        ]),
        body: _buildBody(ctx, "fx"));
  }
}

class FXAdvisorLayout extends StatefulWidget {
  final String collectionName;
 
  FXAdvisorLayout({Key key, @required this.collectionName}) : super(key: key);

  @override
  FXAdvisorLayoutState createState(){
    fxBloc.currentFilter="";
    return new FXAdvisorLayoutState();
  }
}
