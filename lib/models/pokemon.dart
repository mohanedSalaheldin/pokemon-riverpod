class Pokemon {
  final int id;
  final List<Move> moves;
  final String name;
  final Sprites sprites;
  final List<Stat> stats;

  Pokemon({
    required this.id,
    required this.moves,
    required this.name,
    required this.sprites,
    required this.stats,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      moves: (json['moves'] as List)
          .map((move) => Move.fromJson(move['move']))
          .toList(),
      name: json['name'],
      sprites: Sprites.fromJson(json['sprites']),
      stats:
          (json['stats'] as List).map((stat) => Stat.fromJson(stat)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'moves': moves.map((move) => move.toJson()).toList(),
      'name': name,
      'sprites': sprites.toJson(),
      'stats': stats.map((stat) => stat.toJson()).toList(),
    };
  }
}

class Move {
  final String name;
  final String url;

  Move({required this.name, required this.url});

  factory Move.fromJson(Map<String, dynamic> json) {
    return Move(name: json['name'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }
}

class Sprites {
  final String frontDefault;
  final String frontShiny;
  final String frontFemale;
  final String frontShinyFemale;
  final String backDefault;
  final String backShiny;
  final String backFemale;
  final String backShinyFemale;

  Sprites({
    required this.frontDefault,
    required this.frontShiny,
    required this.frontFemale,
    required this.frontShinyFemale,
    required this.backDefault,
    required this.backShiny,
    required this.backFemale,
    required this.backShinyFemale,
  });

  factory Sprites.fromJson(Map<String, dynamic> json) {
    return Sprites(
      frontDefault: json['front_default'] ?? '',
      frontShiny: json['front_shiny'] ?? '',
      frontFemale: json['front_female'] ?? '',
      frontShinyFemale: json['front_shiny_female'] ?? '',
      backDefault: json['back_default'] ?? '',
      backShiny: json['back_shiny'] ?? '',
      backFemale: json['back_female'] ?? '',
      backShinyFemale: json['back_shiny_female'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'front_default': frontDefault,
      'front_shiny': frontShiny,
      'front_female': frontFemale,
      'front_shiny_female': frontShinyFemale,
      'back_default': backDefault,
      'back_shiny': backShiny,
      'back_female': backFemale,
      'back_shiny_female': backShinyFemale,
    };
  }
}

class Stat {
  final int baseStat;
  final int effort;
  final String statName;

  Stat({required this.baseStat, required this.effort, required this.statName});

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
        baseStat: json['base_stat'],
        effort: json['effort'],
        statName: json['stat']['name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'base_stat': baseStat,
      'effort': effort,
      'stat': {'name': statName}
    };
  }
}
