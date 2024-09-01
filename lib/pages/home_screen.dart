import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_pokemon/controllers/home_controller.dart';
import 'package:riverpod_pokemon/models/page_data.dart';
import 'package:riverpod_pokemon/shared/screen_sizes.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../providers/pokemons_provider.dart';
import '../widgets/bokemon_card.dart';
import '../widgets/poke_list_item.dart';

final homePageControllerProvider =
    StateNotifierProvider<HomePageProviderController, HomePageData>(
  (ref) => HomePageProviderController(HomePageData.initial()),
);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late HomePageProviderController _homePageController;
  late HomePageData _homePageData;
  late FavoritePokemonsProvider _favoriteProvider;
  late List<String> _fovoritesPokemons;

  late ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_isTheEndOfTheListReached) {
      _homePageController.loadData();
    }
  }

  bool get _isTheEndOfTheListReached {
    return scrollController.offset >=
            scrollController.position.maxScrollExtent * 1 &&
        !scrollController.position.outOfRange;
  }

  @override
  Widget build(BuildContext context) {
    _homePageController = ref.watch(homePageControllerProvider.notifier);
    _homePageData = ref.watch(homePageControllerProvider);
    _favoriteProvider = ref.watch(favoritePokemonsProvider.notifier);
    _fovoritesPokemons = ref.watch(favoritePokemonsProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Favorite Pokémons',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              _buildFavoritesPokes(context),
              const Text(
                'All Pokémons',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              _buildAllPokes(context)
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildFavoritesPokes(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      height: context.screenHeight * .25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _fovoritesPokemons.isEmpty
              ? const Text(
                  'No Favorite Pokémons',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                )
              : SizedBox(
                  height: context.screenHeight * .25,
                  child: GridView.builder(
                    itemCount: _fovoritesPokemons.length,
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1),
                    itemBuilder: (context, index) => BokeFavoriteCard(
                      pokemonUrl: _fovoritesPokemons[index],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  SizedBox _buildAllPokes(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * .59,
      child: ListView.builder(
        controller: scrollController,
        itemCount:
            _homePageData.data != null ? _homePageData.data?.results.length : 0,
        itemBuilder: (context, index) {
          return PokeListItem(
            pokemonUrl: _homePageData.data?.results[index].url,
          );
        },
      ),
    );
  }
}
