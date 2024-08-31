import 'package:riverpod_pokemon/models/pokemon_list_data.dart';

class HomePageData {
  PokemonListData? data;
  HomePageData({required this.data});

  HomePageData.initial() : data = null;

  HomePageData copyWith({PokemonListData? data}) {
    return HomePageData(data: data ?? this.data);
  }
}
