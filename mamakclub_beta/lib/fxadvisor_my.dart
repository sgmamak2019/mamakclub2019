import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mamakclub_beta/mamakstyles.dart';
import 'package:mamakclub_beta/fxmodel.dart';
import 'package:mamakclub_beta/mamakcard.dart';
import 'package:mamakclub_beta/mamakcommons.dart';
import 'package:mamakclub_beta/collection.dart';
import 'package:mamakclub_beta/mamakhome.dart';

class FXAdvisorLayoutMYState extends State<FXAdvisorLayoutMY> {
 
  Widget _buildListItem(BuildContext context, DocumentSnapshot data,String mode) {
    final FX record = FX.fromSnapShot(data);
    if (data.documentID == "_info") {
      return new Divider();
    }
    if(mode!='NOTES'){
        return new MamakCard(
        cardTitle: data.documentID,
        leftHeader: 'BUY',
        rightHeader: 'SELL',
        leftValue: record.buy_tt,
        rightValue: record.sell_tt,
        leftSubTitle: record.buy_tt_company,
        rightSubTitle: record.sell_tt_company);
    }else{
          return new MamakCard(
        cardTitle: data.documentID,
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

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot,String mode) {
    List<Widget> forBuilding = new List<Widget>();
    forBuilding.add(_buildInfo(context));
  
    forBuilding
        .addAll(snapshot.map((data) => _buildListItem(context, data, mode)).toList());

    return ListView(
        padding: const EdgeInsets.only(top: 20.0), children: forBuilding);
  }
  
  Widget _buildBody(String collectionName,String mode) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection(collectionName).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
         return _buildList(context, snapshot.data.documents,mode);
        });
}

 Widget drawListItem(
      Collection collectionData, BuildContext ctx, IconData icon) {
    return new ListTile(
        title: Text(collectionData.titleName),
        leading: Icon(icon),
        onTap: () {
          setState(() {
           Navigator.of(ctx).pop();
           
           if(collectionData.collectionName == "fx_my"){
              Navigator.of(ctx).push(MaterialPageRoute(
                builder:(BuildContext context)=> new FXAdvisorLayoutMY(collectionName: collectionData.collectionName)
              )); 
           }
           else{
              Navigator.of(ctx).push(MaterialPageRoute(
                builder:(BuildContext context)=> new HomePageLayout(title:collectionData.titleName, collectionName: collectionData.collectionName)
              ));
           }
            
          });
        });
  }
  Widget _drawerList(BuildContext ctx,List<Collection> coll) {
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
    coll.forEach((c) => drawL.add(drawListItem(c, ctx, c.collectionIcon)));
    return new ListView(padding: EdgeInsets.zero, children: drawL);
  }
  
  @override
  Widget build(BuildContext ctx) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: MamakCommons.getMamakDrawer( _drawerList(ctx,MamakCommons.getDefaultCollections())), 
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Text('TT'),
                Text('NOTES')
              ],
            ),
            title: Text('FX (MY)'),
          ),
          body: TabBarView(
            children: [
              _buildBody('fx_my',"TT"),
              _buildBody('fx_my',"NOTES"),
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
  FXAdvisorLayoutMYState createState() => new FXAdvisorLayoutMYState();
}
