import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/govpost.dart';

class TrafficCamProvider {
  Client client = new Client();

  Future<TrafficPost> fetchCams() async {
    final response =
        await client.get("https://api.data.gov.sg/v1/transport/traffic-images");
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return TrafficPost.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
