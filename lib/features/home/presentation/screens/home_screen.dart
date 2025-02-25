import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/pokemon/pokemon_bloc.dart';
import '../../../../blocs/pokemon/pokemon_event.dart';
import '../../../../blocs/pokemon/pokemon_state.dart';
import '../../../../services/api_service.dart';
import '../../../../widgets/custom_appBar_widget.dart';
import '../widgets/pokemon_list_tile_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'Pokemon List',
      ),
      body: BlocProvider(
        create: (context) => PokemonBloc(apiService: ApiService())
          ..add(FetchPokemonListEvent(offset: 0)),
        child: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            if (state is PokemonLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PokemonErrorState) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            }
            if (state is PokemonLoadedState) {
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: state.pokemonList.length,
                itemBuilder: (context, index) {
                  final pokemon = state.pokemonList[index];
                  return PokemonListTile(
                    name: pokemon.name,
                    imageUrl: pokemon.imageUrl,
                    types: pokemon.types,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/pokemonDetail',
                        arguments: pokemon,
                      );
                    },
                  );
                },
              );
            }
            return const Center(child: Text('No Pokémon available'));
          },
        ),
      ),
    );
  }
}
