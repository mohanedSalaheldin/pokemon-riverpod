import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_pokemon/models/page_data.dart';
import 'package:riverpod_pokemon/models/pokemon_list_data.dart';
import 'package:riverpod_pokemon/services/http_service.dart';

class HomePageProviderController extends StateNotifier<HomePageData> {
  final GetIt _getIt = GetIt.instance;
  late HttpService _httpService;

  HomePageProviderController(super._state) {
    _httpService = _getIt.get<HttpService>();
    _setup();
  }

  Future<void> _setup() async {
    loadData();
  }

  Future<void> loadData() async {
    if (state.data == null) {
      var url = "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0";
      Response? res = await _httpService.fetchData(url);
      if (res != null && res.data != null) {
        PokemonListData data = PokemonListData.fromJson(res.data);
        state = state.copyWith(data: data);
      }
      // print(res!.data);
    } else {
      if (state.data?.next != null) {
        Response? res = await _httpService.fetchData(state.data!.next!);
        if (res != null && res.data != null) {
          PokemonListData data = PokemonListData.fromJson(res.data);
          state = state.copyWith(
            data: data.copyWith(
              results: [
                ...state.data!.results,
                ...data.results,
              ],
            ),
          );
        }
      }
    }
  }
}
