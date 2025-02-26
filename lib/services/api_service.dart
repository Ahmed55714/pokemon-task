import 'package:dio/dio.dart';
import 'package:pokemon/models/pokemon.dart';

import '../models/pokemon_detail.dart';

class ApiService {
  final Dio dio = Dio();

  Future<List<Pokemon>> fetchPokemonList(int offset) async {
    try {
      final response = await dio.get(
        'https://pokeapi.co/api/v2/pokemon?limit=100&offset=$offset',
      );
      print("Fetched Pokemon List: ${response.data}");

      if (response.data['results'] != null &&
          response.data['results'].isNotEmpty) {
        final pokemonList =
            response.data['results']
                .map<Pokemon>((e) => Pokemon.fromJson(e))
                .toList();
        return pokemonList;
      } else {
        return []; 
      }
    } catch (e) {
      print("Error fetching Pokemon List: $e");
      rethrow;
    }
  }

  Future<PokemonDetail> fetchPokemonDetails(String id) async {
    try {
      final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$id');
      print("Pokemon Details Response: ${response.data}");
      return PokemonDetail.fromJson(response.data);
    } catch (e) {
      print("Error fetching Pokemon Details: $e");
      rethrow;
    }
  }
}
