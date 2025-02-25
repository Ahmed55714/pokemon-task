import 'package:flutter/material.dart';
import 'package:pokemon/widgets/custom_appBar_widget.dart' show CustomAppBar;

import '../widgets/pokemon_list_tile_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dummyPokemonList = [
      {
        "name": "Pikachu",
        "imageUrl":
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png",
        "types": ["Electric"],
      },
      {
        "name": "Charmander",
        "imageUrl":
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png",
        "types": ["Fire"],
      },
      {
        "name": "Bulbasaur",
        "imageUrl":
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
        "types": ["Grass", "Poison"],
      },
    ];
    return Scaffold(
      appBar: CustomAppBar(
        text: 'Pokemon List',
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: dummyPokemonList.length,
        itemBuilder: (context, index) {
          final pokemon = dummyPokemonList[index];
          return PokemonListTile(
            name: pokemon["name"],
            imageUrl: pokemon["imageUrl"],
            types: List<String>.from(pokemon["types"]),
          );
        },
      ),
    );
  }
}
