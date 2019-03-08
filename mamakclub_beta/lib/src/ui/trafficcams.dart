import 'package:flutter/material.dart';
import 'package:mamakclub_beta/src/models/govpost.dart';
import 'package:mamakclub_beta/src/blocs/trafficcamsbloc.dart';


class TrafficCamsLayoutState extends State<TrafficCamsLayout> {
  @override
  Widget build(BuildContext context) {
    trafficCamBloc.fetchAllCams();
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
