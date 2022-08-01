import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import './env.dart';
import './image.dart';

Future <List<Artist>> fetchArtists() async {
  final response = await http
      .get(Uri.parse('http://ws.audioscrobbler.com/2.0/?method=chart.gettopartists&api_key='+apiKey+'&format=json'));

  if (response.statusCode == 200) {
    final artistsJson =
    jsonDecode(response.body)['artists']['artist'] as List<dynamic>;
    return artistsJson.map((a) => Artist.fromJson(a)).toList();
  } else {
    throw Exception('Failed to load artists');
  }
}

class Artist {
  final String name;
  final int playcount;
  final int listeners;
  final String mbid;
  final String url;
  final String streamable;
  final List<Map<String,String>> images;

  const Artist({
    required this.name,
    required this.playcount,
    required this.listeners,
    required this.mbid,
    required this.url,
    required this.streamable,
    required this.images,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    name: json['name'] ?? '',
    playcount: int.tryParse(json['playcount']) ?? 0,
    listeners: int.tryParse(json['listeners']) ?? 0,
    mbid: json['mbid'] ?? '',
    url: json['url'] ?? '',
    streamable: json['streamable'] ?? '',
    images: List<Map<String,String>>.from(json['image'].map((x) => Image.fromJson(x))),
  );
}