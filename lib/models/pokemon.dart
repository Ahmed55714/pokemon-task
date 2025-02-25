import 'dart:math';

class Pokemon {
  final String name;
  final String imageUrl;
  final String url;
  final List<String> abilities;

  Pokemon({
    required this.name,
    required this.imageUrl,
    required this.url,
    required this.abilities,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    List<String> abilities = [];
    if (json['abilities'] != null) {
      abilities = List<String>.from(
        json['abilities'].map((ability) => ability['ability']['name']),
      );
    }

    if (abilities.isEmpty) {
      abilities = _generateRandomAbilities();
    }

    return Pokemon(
      name: json['name'],
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${json['url'].split('/')[6]}.png',
      url: json['url'],
      abilities: abilities,
    );
  }

  // Generate a list of random abilities for testing
  static List<String> _generateRandomAbilities() {
    final random = Random();
    List<String> possibleAbilities = [
      'Overgrow',
      'Blaze',
      'Torrent',
      'Shield Dust',
      'Compound Eyes',
      'Adaptability',
    ];
    return [possibleAbilities[random.nextInt(possibleAbilities.length)]];
  }
}
