import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import './env.dart';
import './image.dart';

Future <List<Track>> fetchTracks() async {
  final response = await http
      .get(Uri.parse('https://ws.audioscrobbler.com/2.0/?method=chart.gettoptracks&api_key='+apiKey+'&format=json&limit=20'));

  if (response.statusCode == 200) {
    final tracksJson =
    jsonDecode(response.body)['tracks']['track'] as List<dynamic>;
    return tracksJson.map((a) => Track.fromJson(a)).toList();
  } else {
    throw Exception('Failed to load tracks');
  }
}

class Track {
  final String name;
  final int duration;
  final int playcount;
  final int listeners;
  final String url;
  final String artistName;
  final String artistMbid;
  final List<Image> images;

  const Track({
    required this.name,
    required this.duration,
    required this.playcount,
    required this.listeners,
    required this.url,
    required this.artistName,
    required this.artistMbid,
    required this.images,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> _artistJson = json['artist'];
    return Track(
      name: json['name'] ?? '',
      duration: int.tryParse(json['duration'].toString()) ?? 0,
      playcount: int.tryParse(json['playcount']) ?? 0,
      listeners: int.tryParse(json['listeners']) ?? 0,
      url: json['url'] ?? '',
      artistName: _artistJson['name'] ?? '',
      artistMbid: _artistJson['mbid'] ?? '',
      images: List<Image>.from(json['image'].map((x) => Image.fromJson(x))),
    );
  }
}