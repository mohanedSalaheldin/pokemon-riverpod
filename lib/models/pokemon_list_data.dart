class PokemonListData {
  final int count;
  final String? next;
  final String? previous;
  final List<PokeItem> results;

  PokemonListData({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PokemonListData.fromJson(Map<String, dynamic> json) {
    return PokemonListData(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((result) => PokeItem.fromJson(result))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((result) => result.toJson()).toList(),
    };
  }

  PokemonListData copyWith({
    int? count,
    String? next,
    String? previous,
    List<PokeItem>? results,
  }) {
    return PokemonListData(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }
}

class PokeItem {
  final String name;
  final String url;

  PokeItem({
    required this.name,
    required this.url,
  });

  factory PokeItem.fromJson(Map<String, dynamic> json) {
    return PokeItem(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
