import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import './env.dart';
import './image.dart';

Future <List<SearchArtist>> searchArtists(search) async {
  final response = await http
      .get(Uri.parse('http://ws.audioscrobbler.com/2.0/?method=artist.search&artist='+search+'&api_key='+apiKey+'&format=json'));

  if (response.statusCode == 200) {
    final searchJson =
    jsonDecode(response.body)['results']['artistmatches']['artist'] as List<dynamic>;
    return searchJson.map((a) => SearchArtist.fromJson(a)).toList();
  } else {
    throw Exception('Failed to load search');
  }
}

class SearchArtist {
  final String name;
  final int listeners;
  final String mbid;
  final String url;
  final String streamable;
  final List<Image> images;

  const SearchArtist({
    required this.name,
    required this.listeners,
    required this.mbid,
    required this.url,
    required this.streamable,
    required this.images,
  });

  factory SearchArtist.fromJson(Map<String, dynamic> json) => SearchArtist(
    name: json['name'] ?? '',
    listeners: int.tryParse(json['listeners']) ?? 0,
    mbid: json['mbid'] ?? '',
    url: json['url'] ?? '',
    streamable: json['streamable'] ?? '',
    images: List<Image>.from(json['image'].map((x) => Image.fromJson(x))),
  );
}
