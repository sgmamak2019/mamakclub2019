import 'package:flutter/material.dart';
import 'package:mamakclub_beta/src/models/collection.dart';
import 'package:mamakclub_beta/src/ui/fxadvisor.dart';
import 'package:mamakclub_beta/src/ui/fxadvisor_my.dart';
import 'package:mamakclub_beta/src/ui/trafficcams.dart';
import 'package:mamakclub_beta/src/ui/petroladvisor.dart';

class MamakCommons {
  List<Collection> getDefaultCollections() {
    List<Collection> collections = new List<Collection>();

    Collection petrol = new Collection();
    Collection fxsg = new Collection();
    Collection fxmy = new Collection();
    Collection fixed_sg = new Collection();
    Collection fixed_my = new Collection();
    Collection traffic = new Collection();

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
   // collections.add(fixed_sg);
    //collections.add(fixed_my);
    traffic.collectionIcon = Icons.camera_alt;
    traffic.collectionName = "traffic";
    traffic.titleName = "Traffic Cams";
    collections.add(traffic);
    return collections;
  }

  Widget _viewResolver(String colname, String titlen) {
    switch (colname) {
      case "fx_my":
        return new FXAdvisorLayoutMY(collectionName: colname);
        break;
      case "fx":
        return new FXAdvisorLayout(collectionName: colname);
        break;
      case "traffic":
        return new TrafficCamsLayout();
        break;
      case "petrol":
        return new PetrolAdvisorLayout(collectionName: colname);
        break;
    }
  }

  Widget drawListItem(
      Collection collectionData, BuildContext ctx, IconData icon) {
    return new ListTile(
        title: Text(collectionData.titleName),
        leading: Icon(icon),
        onTap: () {
          Navigator.of(ctx).pop();
          Navigator.of(ctx).push(MaterialPageRoute(
              builder: (BuildContext context) => _viewResolver(
                  collectionData.collectionName, collectionData.titleName)));
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
        .getDefaultCollections()
        .forEach((c) => drawL.add(drawListItem(c, ctx, c.collectionIcon)));
    return new ListView(padding: EdgeInsets.zero, children: drawL);
  }

  Widget getMamakDrawer(BuildContext ctx) {
    return new Drawer(child: _drawerList(ctx));
  }

 void getMamakBottomFilter(BuildContext context,Function fn){
     showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              color: Colors.white10,
              height: 400.0,
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(30.0),
                          topRight: const Radius.circular(10))),
                  child: TextField(
                    onChanged: fn
                  )));
        });
  }

  static String getValue(String map) {
    return map == null ? '' : map;
  }
}
