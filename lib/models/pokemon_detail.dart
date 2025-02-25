class PokemonDetail {
  final String name;
  final String imageUrl;
  final String url;
  final List<Ability> abilities;
  final int baseExperience;
  final Cries cries;
  final List<GameIndex> gameIndices;
  final List<Form> forms;
  final List<Stat> stats;

  PokemonDetail({
    required this.name,
    required this.imageUrl,
    required this.url,
    required this.abilities,
    required this.baseExperience,
    required this.cries,
    required this.gameIndices,
    required this.forms,
    required this.stats,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      name: json['name'] ?? 'Unknown',
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${json['id']}.png',
      url: json['url'] ?? '',
      abilities:
          (json['abilities'] as List?)
              ?.map((ability) => Ability.fromJson(ability))
              .toList() ??
          [],
      baseExperience: json['base_experience'] ?? 0,
      cries: Cries.fromJson(
        json['cries'] ?? {},
      ),
      gameIndices:
          (json['game_indices'] as List?)
              ?.map((index) => GameIndex.fromJson(index))
              .toList() ??
          [],
      forms:
          (json['forms'] as List?)
              ?.map((form) => Form.fromJson(form))
              .toList() ??
          [],
      stats:
          (json['stats'] as List?)
              ?.map((stat) => Stat.fromJson(stat))
              .toList() ??
          [],
    );
  }
}

class Stat {
  final String name;
  final int baseStat;

  Stat({required this.name, required this.baseStat});

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(name: json['stat']['name'], baseStat: json['base_stat']);
  }
}

class Ability {
  final String name;
  final String url;
  final bool isHidden;
  final int slot;

  Ability({
    required this.name,
    required this.url,
    required this.isHidden,
    required this.slot,
  });

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(
      name: json['ability']['name'],
      url: json['ability']['url'],
      isHidden: json['is_hidden'],
      slot: json['slot'],
    );
  }
}

class Cries {
  final String latest;
  final String legacy;

  Cries({required this.latest, required this.legacy});

  factory Cries.fromJson(Map<String, dynamic> json) {
    return Cries(latest: json['latest'], legacy: json['legacy']);
  }
}

class GameIndex {
  final int gameIndex;
  final Version version;

  GameIndex({required this.gameIndex, required this.version});

  factory GameIndex.fromJson(Map<String, dynamic> json) {
    return GameIndex(
      gameIndex: json['game_index'],
      version: Version.fromJson(json['version']),
    );
  }
}

class Version {
  final String name;
  final String url;

  Version({required this.name, required this.url});

  factory Version.fromJson(Map<String, dynamic> json) {
    return Version(name: json['name'], url: json['url']);
  }
}

class Form {
  final String name;
  final String url;

  Form({required this.name, required this.url});

  factory Form.fromJson(Map<String, dynamic> json) {
    return Form(name: json['name'], url: json['url']);
  }
}
