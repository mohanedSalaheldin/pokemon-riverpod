import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_pokemon/models/pokemon.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../providers/pokemons_provider.dart';

class PokeListItem extends ConsumerWidget {
  const PokeListItem({super.key, required this.pokemonUrl});

  final String pokemonUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(pokemonProvider(pokemonUrl));

    return pokemon.when(
      data: (data) => _buildUI(context, false, data),
      error: (error, stackTrace) => Text('Erroe: $error'),
      loading: () => _buildUI(context, true, null),
    );
  }

  Widget _buildUI(BuildContext context, bool isLoading, Pokemon? poke) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListTile(
        leading: poke != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(poke.sprites.frontDefault),
              )
            : const CircleAvatar(),
        title: Text(poke != null ? poke.name.toUpperCase() : "Loading Name"),
        subtitle: Text("Has upto ${poke?.moves.length.toString()} Moves"),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite_border,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
