import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/pokemon_detail.dart';
import 'pokemon_event.dart';
import 'pokemon_state.dart';
import '../../services/api_service.dart';
import '../../models/pokemon.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final ApiService apiService;
  final List<Pokemon> _pokemonList = [];
  bool _hasMore = true;

 PokemonBloc({required this.apiService}) : super(PokemonInitialState()) {
    on<FetchPokemonListEvent>((event, emit) async {
      if (!_hasMore) return;
      if (_pokemonList.isEmpty) {
        emit(PokemonLoadingState());
      }

      try {
        final newPokemons = await apiService.fetchPokemonList(event.offset);
        
        if (newPokemons.isEmpty) {
          _hasMore = false;
        } else {
          _pokemonList.addAll(newPokemons);
        }

        emit(PokemonLoadedState(
          pokemonList: List.from(_pokemonList),
          hasMore: _hasMore,
        ));
      } catch (e) {
        emit(PokemonErrorState(message: e.toString()));
      }
    });

    on<FetchPokemonDetailEvent>((event, emit) async {
      emit(PokemonLoadingState());
      try {
        final data = await apiService.fetchPokemonDetails(event.id);
        print("Fetched Pokemon Detail: $data");

        final pokemonDetail = PokemonDetail.fromJson(
          data as Map<String, dynamic>,
        );

        emit(PokemonDetailLoadedState(pokemonDetail: pokemonDetail));
      } catch (e) {
        emit(PokemonErrorState(message: e.toString()));
      }
    });
  }
}
