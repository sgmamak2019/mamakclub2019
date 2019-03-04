import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mamakclub_beta/govpost.dart';
import 'package:http/http.dart' as http;

Future<TrafficPost> fetchPost() async {
    final response =
        await http.get('https://api.data.gov.sg/v1/transport/traffic-images');
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return TrafficPost.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
}

class TrafficCamsLayoutState extends State<TrafficCamsLayout> {
  Future<TrafficPost> post;
  @override
  Widget build(BuildContext context) {
    return new Container(
        child:FutureBuilder<TrafficPost>(
          future:fetchPost(),
          builder:(context,snapshot){
             if (snapshot.hasData) {
                return _buildCamViews(snapshot.data);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
               return CircularProgressIndicator();
          }
        )
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
