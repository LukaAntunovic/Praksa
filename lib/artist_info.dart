import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import './env.dart';
import './image.dart';

Future <ArtistInfo> fetchArtistInfo(name) async {
  final response = await http
      .get(Uri.parse('https://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist='+name+'&api_key='+apiKey+'&format=json'));

  if (response.statusCode == 200) {
    final artistsInfoJson =
    jsonDecode(response.body)['artist'];
    return ArtistInfo.fromJson(artistsInfoJson);
  } else {
    throw Exception('Failed to load artists info');
  }
}

class ArtistInfo {
  final String name;
  final int playcount;
  final int listeners;
  final String mbid;
  final String url;
  final String streamable;
  final List<Image> images;
  final String published;
  final String summary;
  final String content;

  const ArtistInfo({
    required this.name,
    required this.playcount,
    required this.listeners,
    required this.mbid,
    required this.url,
    required this.streamable,
    required this.images,
    required this.published,
    required this.summary,
    required this.content,
  });

  factory ArtistInfo.fromJson(Map<String, dynamic> json) => ArtistInfo(
    name: json['name'] ?? '',
    playcount: int.tryParse(json['playcount']) ?? 0,
    listeners: int.tryParse(json['listeners']) ?? 0,
    mbid: json['mbid'] ?? '',
    url: json['url'] ?? '',
    streamable: json['streamable'] ?? '',
    images: List<Image>.from(json['image'].map((x) => Image.fromJson(x))),
    published: json['published'] ?? '',
    summary: json['summary'] ?? '',
    content: json['content'] ?? '',
  );
}