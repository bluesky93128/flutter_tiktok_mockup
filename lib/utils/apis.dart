import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List> getVideos() async {
  final response = await http.get(
      'https://my-json-server.typicode.com/bluesky93128/tiktok_mock_db/videos');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List videos = json.decode(response.body);
    List users = List();
    List ret = List(2);
    final res = await http.get(
      'https://randomuser.me/api/?results='+videos.length.toString());
    if(res.statusCode == 200) {
      users = json.decode(res.body)['results'];
      ret[0] = videos;
      ret[1] = users;
      return ret;
    } else {
      throw Exception('Failed to load users data');
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load video data');
  }
}

