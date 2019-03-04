import 'package:flutter/material.dart';
import 'package:mamakclub_beta/collection.dart';
//import 'package:mamakclub_beta/petrol.dart';
import 'package:mamakclub_beta/petroladvisor.dart';
//import 'package:mamakclub_beta/fx.dart';
import 'package:mamakclub_beta/fxadvisor.dart';
import 'package:mamakclub_beta/fxadvisor_my.dart';
import 'package:mamakclub_beta/fixed_deposit.dart';
import 'package:mamakclub_beta/mamakcommons.dart';
class HomePageLayoutState extends State<HomePageLayout> {
  //_buildBody(currentCollection);
  List<Collection> collections;

  void initCollections() {
    this.collections = MamakCommons.getDefaultCollections();
  }
  Widget _getCurrentWidget(String colname) {
    switch (colname) {
      case "petrol":
        return new PetrolAdvisorLayout();
        break;
      case "fx":
      return new FXAdvisorLayout(collectionName:colname);
        break;
      case "fixed_deposit_my":
       case "fixed_deposit_sg":
        return new FixedDepositLayout (collectionName: colname);
        break;
    }
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
    this.collections.forEach((c) => drawL.add(drawListItem(c, ctx, c.collectionIcon)));
    return new ListView(padding: EdgeInsets.zero, children: drawL);
  }
 Widget _buildScaffold(BuildContext ctx) {
    return new Scaffold(
        drawer: MamakCommons.getMamakDrawer(_drawerList(ctx)), 
        //new Drawer(child: _drawerList(ctx)),
        appBar: AppBar(title: Text(widget.title)),
        body: _getCurrentWidget(widget.collectionName)
        );
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
