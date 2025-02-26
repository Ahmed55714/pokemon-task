import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/models/pokemon.dart' show Pokemon;
import '../../../../blocs/pokemon/pokemon_bloc.dart';
import '../../../../blocs/pokemon/pokemon_event.dart';
import '../../../../blocs/pokemon/pokemon_state.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/image_path.dart';
import '../../../../helper/responsive_helper.dart';
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
  late final PokemonBloc _pokemonBloc;
  int _offset = 0;
  static const int _limit = 20;

  @override
  void initState() {
    super.initState();
    _pokemonBloc = PokemonBloc(apiService: ApiService());
    _pokemonBloc.add(FetchPokemonListEvent(offset: _offset));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchMorePokemons();
    }
  }

  void _fetchMorePokemons() {
    _offset += _limit;
    _pokemonBloc.add(FetchPokemonListEvent(offset: _offset));
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return Scaffold(
      appBar: CustomAppBar(text: 'Pokemon List', isBackButtonVisible: false),
      body: BlocProvider(
        create: (context) => _pokemonBloc,
        child: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            if (state is PokemonLoadingState && _offset == 0) {
              return _buildLoadingIndicator(responsive);
            } else if (state is PokemonErrorState) {
              return _buildErrorMessage(state.message, responsive);
            } else if (state is PokemonLoadedState) {
              return _buildPokemonList(state, responsive);
            }
            return _buildEmptyState(responsive);
          },
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator(ResponsiveHelper responsive) {
    return Center(
      child: SizedBox(
        height: responsive.height(0.05),
        width: responsive.height(0.05),
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorMessage(String message, ResponsiveHelper responsive) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(responsive.width(0.04)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImagePaths.pokemon,
              width: responsive.width(0.25),
              height: responsive.width(0.25),
              fit: BoxFit.cover,
            ),
            Container(
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(responsive.width(0.02)),
          color: AppColors.greyLight,
        ),
              padding: EdgeInsets.all(responsive.width(0.02)),
              child: Text(
                'Error loading Pokémon list',
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: responsive.width(0.045),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPokemonList(
    PokemonLoadedState state,
    ResponsiveHelper responsive,
  ) {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.all(responsive.width(0.03)),
      itemCount: state.pokemonList.length + (state.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == state.pokemonList.length) {
          return _buildPaginationLoadingIndicator(responsive);
        }
        return _buildPokemonTile(state.pokemonList[index]);
      },
    );
  }

  Widget _buildPaginationLoadingIndicator(ResponsiveHelper responsive) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(responsive.height(0.02)),
        child: SizedBox(
          height: responsive.height(0.04),
          width: responsive.height(0.04),
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildPokemonTile(Pokemon pokemon) {
    return PokemonListTile(
      name: pokemon.name,
      imageUrl: pokemon.imageUrl,
      types: pokemon.abilities,
      onTap: () {
        final pokemonId = pokemon.url.split('/')[6];
        Navigator.pushNamed(context, '/pokemonDetail', arguments: pokemonId);
      },
    );
  }

  Widget _buildEmptyState(ResponsiveHelper responsive) {
    return Center(
      child: Text(
        'No Pokémon available',
        style: TextStyle(fontSize: responsive.width(0.05)),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _pokemonBloc.close();
    super.dispose();
  }
}
