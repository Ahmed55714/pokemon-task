abstract class PokemonEvent {}

class FetchPokemonListEvent extends PokemonEvent {
  final int offset;

  FetchPokemonListEvent({required this.offset});
}

class FetchPokemonDetailEvent extends PokemonEvent {
  final String id;

  FetchPokemonDetailEvent({required this.id});
}
