import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'androidVersions powered by Flutter',
      theme: ThemeData(          // Add the 5 lines from here...
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
      ),

      home: Scaffold(

        appBar: AppBar(
          title: const Text('androidVersions powered by Flutter'),
        ),
        body: const Center(

          child: RandomWords(),
        ),
      ),
    );
  }
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <String>["Android 1.0", "Android 1.1", "Android Cupcake", "Android Donut", "Android Eclair", "Android Froyo", "Android Gingerbread", "Android Honeycomb", "Android Ice Cream Sandwich", "Android Jelly Bean","Android KitKat","Android Lollipop","Android Marshmallow","Android Nougat", "Android Oreo", "Android Pie", "Android 10", "Android 11","Android 12","Android 12L","Android 13"];
  final _saved = <String>{};
  final _biggerFont = const TextStyle(fontSize: 18);

  void _pushSaved() {
    Navigator.of(context).push(
      // Add lines from here...
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
                (pair) {
              return ListTile(
                title: Text(
                  pair,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Fav android versions'),
            ),
            body: ListView(children: divided),
          );
        },
      ), // ...to here.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(   // NEW from here ...
        appBar: AppBar(
        title: const Text('Android Desserts'),
    actions: [
      IconButton(
        icon: const Icon(Icons.list),
        onPressed: _pushSaved,
        tooltip: 'Fav android versions',
      ),
    ],
    ),
    body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return const Divider(); /*2*/
            final index = i ~/ 2; /*3*/
            final alreadySaved = _saved.contains(_suggestions[index]); // NEW
              if (index < _suggestions.length) {
                  _suggestions.add(_suggestions[index]); /*4*/
                }
              return ListTile(
                title: Text(
                  _suggestions[index],
                  style: _biggerFont,
                ),
                trailing: Icon(    // NEW from here ...
                  alreadySaved ? Icons.favorite : Icons.favorite_border,
                  color: alreadySaved ? Colors.red : null,
                  semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
                ),
                onTap: () {          // NEW from here ...
                  setState(() {
                    if (alreadySaved) {
                      _saved.remove(_suggestions[index]);
                    } else {
                      _saved.add(_suggestions[index]);
                    }
                  });
                },
               );
      	         },
    )
                );
         }
  }

  class RandomWords extends StatefulWidget {
    const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
  }

