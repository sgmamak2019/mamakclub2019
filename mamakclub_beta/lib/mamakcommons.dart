import 'package:flutter/material.dart';
import 'package:mamakclub_beta/src/ui/fxadvisor_my.dart';
import 'package:mamakclub_beta/src/ui/trafficcams.dart';
import 'package:mamakclub_beta/src/ui/petroladvisor.dart';
import 'package:mamakclub_beta/src/blocs/mainbloc.dart';
import 'package:mamakclub_beta/src/models/commoditiesmodel.dart';
class MamakCommons {
  
  Widget _viewResolver(String colname, String titlen,String snap) {
    switch (colname) {
      case "fx_my":
      case "fx":
        return new FXAdvisorLayoutMY(collectionName: colname,snap_nicedate:snap);
        break;
      case "traffic":
        return new TrafficCamsLayout();
        break;
      case "petrol":
        return new PetrolAdvisorLayout(collectionName: colname,snap_nicedate: snap);
        break;
      default :
       return new PetrolAdvisorLayout(collectionName: colname,snap_nicedate: snap);
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
                  collectionData.documentId, collectionData.commodity_desc,collectionData.snap_nicedate)));
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
    if(mainBloc.hasLoaded==false){
      mainBloc.fetchAllCommodities();
    }
    return new Container(
      child: StreamBuilder(
      stream:mainBloc.allComms, 
      builder:(context, AsyncSnapshot<List<Commodities>> snapshot){
      
        if(snapshot.hasData){
          return new ListView(
            children: this.drawerItemsGen(context,snapshot.data),
          );
        }
        else{
         return new ListView(
            children: this.drawerItemsGen(context,mainBloc.localComms),
          );
        }
      
      }
      ));
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
