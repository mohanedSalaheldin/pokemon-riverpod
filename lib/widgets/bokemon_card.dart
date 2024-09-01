import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_pokemon/models/pokemon.dart';
import 'package:riverpod_pokemon/providers/pokemons_provider.dart';
import 'package:riverpod_pokemon/shared/screen_sizes.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BokeFavoriteCard extends ConsumerWidget {
  BokeFavoriteCard({
    super.key,
    this.pokemonUrl,
  });
  final String? pokemonUrl;
  late FavoritePokemonsProvider _favoriteProvider;
  late List<String> _fovoritesPokemons;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(pokemonProvider(pokemonUrl ?? ''));
    _favoriteProvider = ref.watch(favoritePokemonsProvider.notifier);
    _fovoritesPokemons = ref.watch(favoritePokemonsProvider);
    return pokemon.when(
      data: (data) => _buildUI(context, false, data),
      error: (error, stackTrace) => Text('Erroe: $error'),
      loading: () => _buildUI(context, true, null),
    );
  }

  Widget _buildUI(BuildContext context, bool isLoading, Pokemon? poke) {
    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        height: context.screenHeight * .20,
        width: context.screenHeight * .20,
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 61, 73, 48),
              Color.fromARGB(255, 106, 146, 59),
            ],
          ),
          // color:,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  poke != null ? poke.name.toUpperCase() : "Loading Name",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '#${poke != null ? poke.id : "00"}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            poke != null
                ? CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(poke.sprites.frontDefault))
                : const CircleAvatar(radius: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  poke != null
                      ? "${poke.moves.length.toString()} Moves"
                      : "Loading Name",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_fovoritesPokemons.contains(pokemonUrl)) {
                      _favoriteProvider.reomveFromFavorites(pokemonUrl!);
                    } else {
                      _favoriteProvider.addToFavorites(pokemonUrl!);
                    }
                  },
                  icon: Icon(
                    _fovoritesPokemons.contains(pokemonUrl)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
