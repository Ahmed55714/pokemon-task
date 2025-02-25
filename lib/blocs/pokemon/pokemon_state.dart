import '../../models/pokemon.dart' show Pokemon;
import '../../models/pokemon_detail.dart';

abstract class PokemonState {}

class PokemonInitialState extends PokemonState {}

class PokemonLoadingState extends PokemonState {}

class PokemonLoadedState extends PokemonState {
  final List<Pokemon> pokemonList;
  final bool hasMore;

  PokemonLoadedState({required this.pokemonList, required this.hasMore});
}

class PokemonDetailLoadedState extends PokemonState {
  final PokemonDetail pokemonDetail;

  PokemonDetailLoadedState({required this.pokemonDetail});
}

class PokemonErrorState extends PokemonState {
  final String message;

  PokemonErrorState({required this.message});
}
