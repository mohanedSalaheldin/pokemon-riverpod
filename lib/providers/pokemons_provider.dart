import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_pokemon/models/pokemon.dart';
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
