import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mamakclub_beta/mamakstyles.dart';
import 'package:mamakclub_beta/src/models/fxmodel.dart';
import 'package:mamakclub_beta/mamakcard.dart';
import 'package:mamakclub_beta/src/blocs/fxbloc.dart';

class FXAdvisorLayoutState extends State<FXAdvisorLayout> {
 
  Widget _buildListItem(BuildContext context, FX data) {
   // final FX record = FX.fromSnapShot(data);
    //if (data.documentID == "_info") {
     // return new Divider();
   // }
    return new MamakCard(
        cardTitle: data.documentId,
        leftHeader: 'BUY',
        rightHeader: 'SELL',
        leftValue: data.buy_tt,
        rightValue: data.sell_tt,
        leftSubTitle: data.buy_tt_company,
        rightSubTitle: data.sell_tt_company);
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

  Widget _buildList( List<FX> snapshot) {
    List<Widget> forBuilding = new List<Widget>();
    forBuilding.add(_buildInfo(context));
    forBuilding
        .addAll(snapshot.map((data) => _buildListItem(context, data)).toList());

    return ListView(
        padding: const EdgeInsets.only(top: 20.0), children: forBuilding);
  }

  Widget _buildBody(BuildContext context,String collectionName) {
    fxBloc.fetchAllSGFX();
       return new Container(
        child:StreamBuilder(
          stream:fxBloc.allSGFx,
          builder:(context,AsyncSnapshot<FXRecord> snapshot){
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
    return _buildBody(ctx,widget.collectionName);
  }
}

class FXAdvisorLayout extends StatefulWidget {
  final String collectionName;

  FXAdvisorLayout({Key key, @required this.collectionName}) : super(key: key);

  @override
  FXAdvisorLayoutState createState() => new FXAdvisorLayoutState();
}
