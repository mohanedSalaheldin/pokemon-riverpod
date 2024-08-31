import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_pokemon/controllers/home_controller.dart';
import 'package:riverpod_pokemon/models/page_data.dart';
import 'package:riverpod_pokemon/shared/screen_sizes.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'All Pokémons',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: context.screenHeight * .90,
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: _homePageData.data != null
                      ? _homePageData.data?.results.length
                      : 0,
                  itemBuilder: (context, index) {
                    return PokeListItem(
                      pokemonUrl: _homePageData.data?.results[index].url ?? "",
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
