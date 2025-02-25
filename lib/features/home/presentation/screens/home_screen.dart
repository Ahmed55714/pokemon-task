import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/pokemon/pokemon_bloc.dart';
import '../../../../blocs/pokemon/pokemon_event.dart';
import '../../../../blocs/pokemon/pokemon_state.dart';
import '../../../../services/api_service.dart';
import '../../../../widgets/custom_appBar_widget.dart';
import '../widgets/pokemon_list_tile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  late PokemonBloc _pokemonBloc;
  int _offset = 0;
  final int _limit = 20;

  @override
  void initState() {
    super.initState();
    _pokemonBloc = PokemonBloc(apiService: ApiService());
    _pokemonBloc.add(FetchPokemonListEvent(offset: _offset));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchMorePokemons();
      }
    });
  }

  void _fetchMorePokemons() {
    _offset += _limit;
    _pokemonBloc.add(FetchPokemonListEvent(offset: _offset));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: 'Pokemon List'),
      body: BlocProvider(
        create: (context) => _pokemonBloc,
        child: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            if (state is PokemonLoadingState && _offset == 0) {
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
                controller: _scrollController,
                padding: const EdgeInsets.all(8.0),
                itemCount: state.pokemonList.length + (state.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == state.pokemonList.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  final pokemon = state.pokemonList[index];
                  return PokemonListTile(
                    name: pokemon.name,
                    imageUrl: pokemon.imageUrl,
                    types: pokemon.abilities,
                    onTap: () {
                      final pokemonId = pokemon.url.split('/')[6];
                      Navigator.pushNamed(
                        context,
                        '/pokemonDetail',
                        arguments: pokemonId,
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

  @override
  void dispose() {
    _scrollController.dispose();
    _pokemonBloc.close();
    super.dispose();
  }
}
