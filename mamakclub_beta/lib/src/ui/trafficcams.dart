import 'package:flutter/material.dart';
import 'package:mamakclub_beta/src/models/govpost.dart';
import 'package:mamakclub_beta/src/blocs/trafficcamsbloc.dart';
import 'package:mamakclub_beta/mamakcommons.dart';

class TrafficCamsLayoutState extends State<TrafficCamsLayout> {
  MamakCommons mamakCommons =MamakCommons();

  Widget _buildBody(BuildContext ctx){
    return new Container(
        child:StreamBuilder(
          stream :trafficCamBloc.allCams,
          builder:(context,AsyncSnapshot<TrafficPost> snapshot){
            if (snapshot.hasData) {
                return _buildCamViews(snapshot.data);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
               return Center(child:CircularProgressIndicator());
          }
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    trafficCamBloc.fetchAllCams();
    return Scaffold(
        drawer: mamakCommons.getMamakDrawer(context),
        appBar: AppBar(
          title: Text('Traffic Cameras [SG]'),
        ),
        body: _buildBody(context)
      );
    /**/
  }
}
Widget _buildCardItem(TrafficCam camItem){
   return new Container(
     child: new Image.network(camItem.image)
   );
}
Widget _buildCamViews(TrafficPost postData){
    List<Widget> forBuilding = new List<Widget>();
    forBuilding.add(Text(postData.apinfo.status));
    forBuilding.addAll(postData.items.cameras.map((data)=>_buildCardItem(data)).toList());
  return new ListView(
      children: forBuilding,
    );
}
class TrafficCamsLayout extends StatefulWidget {
  @override
  TrafficCamsLayoutState createState() => new TrafficCamsLayoutState();
}
