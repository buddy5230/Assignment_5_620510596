import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(
      items: List<String>.generate(150, (i) => 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/${i+1}.png'), // generate a list of 150 Pokemon
    ),
  );
}

class MyApp extends StatefulWidget {
  final List<String> items;

  const MyApp({super.key, required this.items});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _favoriteCount = 0;

  void _incrementFavoriteCount() {
    setState(() {
      _favoriteCount++;
    });
  }

  void _decrementFavoriteCount() {
    setState(() {
      _favoriteCount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Pokemon List ($_favoriteCount)')
          ),
        ),
        body: ListView.builder(
          itemCount: widget.items.length ~/ 3,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Image.network(widget.items[index * 3]),
                      FavoriteWidget(
                        onIncrement: _incrementFavoriteCount,
                        onDecrement: _decrementFavoriteCount,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Image.network(widget.items[index * 3 + 1]),
                      FavoriteWidget(
                        onIncrement: _incrementFavoriteCount,
                        onDecrement: _decrementFavoriteCount,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Image.network(widget.items[index * 3 + 2]),
                      FavoriteWidget(
                        onIncrement: _incrementFavoriteCount,
                        onDecrement: _decrementFavoriteCount,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  final void Function() onIncrement;
  final void Function() onDecrement;

  const FavoriteWidget({super.key, required this.onIncrement, required this.onDecrement});

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        widget.onDecrement();
        _isFavorited = false;
      } else {
        widget.onIncrement();
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggleFavorite,
      icon: (_isFavorited
          ? const Icon(Icons.favorite, size: 50,)
          : const Icon(Icons.favorite_border, size: 50,)),
      color: Colors.red,
    );
  }
}


