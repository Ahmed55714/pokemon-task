import 'dart:math';

class Pokemon {
  final String name;
  final String imageUrl;
  final String url;
  final List<String> types;

  Pokemon({
    required this.name,
    required this.imageUrl,
    required this.url,
    required this.types,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    List<String> types = [];
    if (json['types'] != null) {
      types = List<String>.from(
        json['types'].map((type) => type['type']['name']),
      );
    }

    if (types.isEmpty) {
      types = _generateRandomTypes();
    }

    return Pokemon(
      name: json['name'],
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${json['url'].split('/')[6]}.png',
      url: json['url'],
      types: types,
    );
  }

  // Generate a list of random types for testing
  static List<String> _generateRandomTypes() {
    final random = Random();
    List<String> possibleTypes = [
      'Fire',
      'Water',
      'Grass',
      'Electric',
      'Psychic',
      'Bug',
      'Ghost',
    ];
    // Return a random selection of types
    return [possibleTypes[random.nextInt(possibleTypes.length)]];
  }
}
