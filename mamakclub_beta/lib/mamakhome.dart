import 'package:flutter/material.dart';
import 'package:mamakclub_beta/collection.dart';
//import 'package:mamakclub_beta/petrol.dart';
import 'package:mamakclub_beta/petroladvisor.dart';
//import 'package:mamakclub_beta/fx.dart';
import 'package:mamakclub_beta/fxadvisor.dart';
import 'package:mamakclub_beta/fixed_deposit.dart';
class HomePageLayoutState extends State<HomePageLayout> {
  
  //_buildBody(currentCollection);
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

  Widget _getCurrentWidget(String colname) {
    switch (colname) {
      case "petrol":
        //HI jason, this is the petrol Advisor Layout(petroladvisor.dart).
        //I made it, as a replacement for PetrolLayout(petrol.dart)
        //petrol advisor lacks or icons. If you want the excel looking gui, 
        //just replace the import to import petrol.dart
        //use new PetrolLayout() instead of below.
        //I also made "MamakCard" Component, which you can use...
        return new PetrolAdvisorLayout();
        break;
      case "fx":
      case "fx_my" :
        //return new FXLayout(collectionName: colname);
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
            Navigator.of(ctx).push(MaterialPageRoute(
               builder:(BuildContext context)=> new HomePageLayout(title:collectionData.titleName, collectionName: collectionData.collectionName)
             ));
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
    this
        .collections
        .forEach((c) => drawL.add(drawListItem(c, ctx, c.collectionIcon)));
    return new ListView(padding: EdgeInsets.zero, children: drawL);
  }

  Widget _buildScaffold(BuildContext ctx) {
    return new Scaffold(
        drawer: new Drawer(child: _drawerList(ctx)),
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
