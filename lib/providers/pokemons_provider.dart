import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_pokemon/models/pokemon.dart';
import 'package:riverpod_pokemon/services/cache_services.dart';
import 'package:riverpod_pokemon/services/http_service.dart';

final pokemonProvider = FutureProvider.family<Pokemon?, String>(
  (ref, arg) async {
    HttpService httpService = GetIt.instance.get<HttpService>();
    Response? res = await httpService.fetchData(arg);
    if (res != null && res.data != null) {
      Pokemon pokemon = Pokemon.fromJson(res.data);
      return pokemon;
    }
    return null;
  },
);

final favoritePokemonsProvider =
    StateNotifierProvider<FavoritePokemonsProvider, List<String>>(
  (ref) => FavoritePokemonsProvider([]),
);

class FavoritePokemonsProvider extends StateNotifier<List<String>> {
  final CacheServices _cacheServices = GetIt.instance.get<CacheServices>();
  FavoritePokemonsProvider(super._state) {
    _setup();
  }
  final String FAVORITES_POKEMONS = "FAVORITES_POKEMONS";

  Future<void> _setup() async {
    state = await _cacheServices.getList(FAVORITES_POKEMONS);
  }

  void addToFavorites(String url) {
    state = [...state, url];
    _cacheServices.saveList(FAVORITES_POKEMONS, state);
  }

  void reomveFromFavorites(String url) {
    state = state.where((e) => e != url).toList();
    _cacheServices.saveList(FAVORITES_POKEMONS, state);
  }
}
