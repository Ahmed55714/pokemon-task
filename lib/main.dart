import 'package:flutter/material.dart';
import 'package:pokemon/features/details/presentation/screens/pokemon_detail_screen.dart' show PokemonDetailScreen;

import 'features/home/presentation/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon App',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomeScreen(),
        '/pokemonDetail': (context) => PokemonDetailScreen(pokemonId: ModalRoute.of(context)!.settings.arguments as String),
      },
    );
  }
}