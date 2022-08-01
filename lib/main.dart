import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import './screens.dart';

void main(){
  //LastFM lastfm = LastFMUnauthorized(apiKey, sharedSecret);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[
    MainScreen(),
    TopArtistsScreen(),
    TopTracksScreen(),
    SearchScreen(),
  ];

  static const List<Widget> _titles = <Widget>[
    Text('Home'),
    Text('Top Artists'),
    Text('Top Tracks'),
    Text('Search'),
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    //final textTheme = Theme.of(context).textTheme;

    const double iconSize = 32.0;
    return Scaffold(
      appBar: AppBar(
          title: Center(
            child: _titles.elementAt(_selectedIndex),
          ),
      ),
      body: _screens.elementAt(_selectedIndex),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorScheme.onSurface,
        unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: iconSize),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt, size: iconSize),
            label: 'Top Artists',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note, size: iconSize),
            label: 'Top Tracks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: iconSize),
            label: 'Search',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
      ),
    );
  }
}

