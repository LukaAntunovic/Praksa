import 'dart:async';

import 'package:flutter/material.dart';

import './tracks.dart';
import './artists.dart';
import './search.dart';
import './artist_info.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Screen',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}


class TopArtistsScreen extends StatefulWidget {
  const TopArtistsScreen({Key? key}) : super(key: key);

  @override
  State<TopArtistsScreen> createState() => _TopArtistsScreen();
}

class _TopArtistsScreen extends State<TopArtistsScreen> {
  late Future<List<Artist>> futureArtists;

  @override
  void initState() {
    super.initState();
    futureArtists = fetchArtists();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Artist>>(
        future: futureArtists,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          List<Artist> artists = snapshot.data ?? [];
          return ListView.builder(
            itemCount: artists.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                //leading: const Icon(Icons.person, size: 50),
                leading: Image.network((artists[index].images[0])['#text']!) ,
                title: Text(artists[index].name),
                subtitle: Row(
                    children: <Widget>[
                      Text((artists[index].listeners).toString()),
                      const Text(" listeners"),

                      const Text(" | Playcount: "),
                      Text((artists[index].playcount).toString()),
                    ]
                ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArtistInfoScreen(),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}


class TopTracksScreen extends StatefulWidget {
  const TopTracksScreen({Key? key}) : super(key: key);

  @override
  State<TopTracksScreen> createState() => _TopTracksScreen();
}

class _TopTracksScreen extends State<TopTracksScreen> {
  late Future<List<Track>> futureTracks;

  @override
  void initState() {
    super.initState();
    futureTracks = fetchTracks();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Track>>(
        future: futureTracks,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          List<Track> track = snapshot.data ?? [];
          return ListView.builder(
            itemCount: track.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                leading: const Icon(Icons.music_note, size: 50,),
                title: Row(
                    children: <Widget>[
                      Text(track[index].name + '\n' + track[index].artistName),
                    ]
                ),
                subtitle: Row(
                    children: <Widget>[
                      Text((track[index].listeners).toString()),
                      const Text(" listeners"),

                      const Text(" | Playcount: "),
                      Text((track[index].playcount).toString()),
                      //Text(((track[index].listeners).toString()) + " listeners" + '\n' + "Playcount: " + ((track[index].playcount).toString())),
                    ]
                ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  late Future<List<SearchArtist>> search;

  TextEditingController searchController =  TextEditingController();

  @override
  void initState() {
    super.initState();
    search = searchArtists((' '));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                        },
                      ),
                      hintText: 'Search...',
                      border: InputBorder.none),
                      onChanged: (text) {
                        setState(() {
                          search = searchArtists((searchController.text));
                        });
                        if((searchController.text).isEmpty) {
                          setState(() {
                            search = searchArtists((' '));
                          });
                        }
                      },
                ),
              ),
            ),
        ),
        body: Center(
          child: FutureBuilder<List<SearchArtist>>(
            future: search,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              List<SearchArtist> search = snapshot.data ?? [];
              return ListView.builder(
                itemCount: search.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.person_outline, size: 36),
                      //leading: ImageIcon((artists[index].images[0]) as ImageProvider),
                      title: Text(search[index].name),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArtistInfoScreen(),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
    );
  }
}


class ArtistInfoScreen extends StatefulWidget {
  const ArtistInfoScreen({Key? key}) : super(key: key);

  @override
  State<ArtistInfoScreen> createState() => _ArtistInfoScreen();
}

class _ArtistInfoScreen extends State<ArtistInfoScreen> {
  late Future<ArtistInfo> futureArtistInfo;

  @override
  void initState() {
    super.initState();
    futureArtistInfo = fetchArtistInfo('Cher');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artist Info'),
      ),
      body: Center(
        child: FutureBuilder <ArtistInfo>(
          future: futureArtistInfo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            //<ArtistInfo> info = snapshot.data ?? ' ';
            return Text('info.name');
          },
        ),
      ),
    );
  }
}