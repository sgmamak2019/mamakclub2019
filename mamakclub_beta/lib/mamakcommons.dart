import 'package:flutter/material.dart';
import 'package:mamakclub_beta/src/models/collection.dart';
import 'package:mamakclub_beta/src/ui/fxadvisor_my.dart';
import 'package:mamakclub_beta/src/ui/trafficcams.dart';
import 'package:mamakclub_beta/src/ui/petroladvisor.dart';
import 'package:mamakclub_beta/src/blocs/mainbloc.dart';
import 'package:mamakclub_beta/src/models/commoditiesmodel.dart';
class MamakCommons {
  
  List<Commodities> getDefaultCollections() {
    CommoditiesRecord rec = new CommoditiesRecord();
    Future<CommoditiesRecord> record = mainBloc.fetchAllCommodities();
    record.then((results)=>rec=results);
    return rec.items;
  }

  Widget _viewResolver(String colname, String titlen) {
    switch (colname) {
      case "fx_my":
      case "fx":
        return new FXAdvisorLayoutMY(collectionName: colname);
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
      Commodities collectionData, BuildContext ctx) {
    return new ListTile(
        title: Text(collectionData.documentId),
        //leading: Icon(icon),
        onTap: () {
          Navigator.of(ctx).pop();
          Navigator.of(ctx).push(MaterialPageRoute(
              builder: (BuildContext context) => _viewResolver(
                  collectionData.documentId, collectionData.commodity)));
        });
  }
  List<Widget> drawerItemsGen(BuildContext ctx,List<Commodities> r){
      List<Widget> allWids = new List<Widget>();
      allWids.add( new Container(
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
     r.forEach((c) => allWids.add(drawListItem(c, ctx)));
    return allWids;

  }
  Widget buildDraw(BuildContext context){
    mainBloc.fetchAllCommodities();
    return new Container(
      child: StreamBuilder(
      stream:mainBloc.allComms, 
      builder:(context, AsyncSnapshot<CommoditiesRecord> snapshot){
        if (snapshot.hasData) {
          return ListView(
            children: drawerItemsGen(context,snapshot.data.items),
          );
        }else if (snapshot.hasError) {
            return Text("${snapshot.error}");
        }
        else{
           return Center(child: CircularProgressIndicator());
        }  
      }
      ));
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
        .forEach((c) => drawL.add(drawListItem(c, ctx)));
    return new ListView(padding: EdgeInsets.zero, children: drawL);
  }

  Widget getMamakDrawer(BuildContext ctx) {
    return new Drawer(child: buildDraw(ctx));
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
