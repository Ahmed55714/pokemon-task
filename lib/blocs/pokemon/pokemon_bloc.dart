import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/pokemon_detail.dart';
import 'pokemon_event.dart';
import 'pokemon_state.dart';
import '../../services/api_service.dart';
import '../../models/pokemon.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final ApiService apiService;

  PokemonBloc({required this.apiService}) : super(PokemonInitialState()) {
    on<FetchPokemonListEvent>((event, emit) async {
      emit(PokemonLoadingState());
      try {
        final data = await apiService.fetchPokemonList(event.offset);
        print("Fetched Pokemon List: $data");

        if (data.isEmpty) {
          emit(PokemonErrorState(message: "No Pokemon found."));
        } else {
          final pokemonList = data;
          emit(
            PokemonLoadedState(
              pokemonList: pokemonList,
              hasMore: data.isNotEmpty,
            ),
          );
        }
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
