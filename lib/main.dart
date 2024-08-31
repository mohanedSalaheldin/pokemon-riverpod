import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_pokemon/pages/home_screen.dart';
import 'package:riverpod_pokemon/services/http_service.dart';

void main() async {
  await _setUpServices();
  runApp(const MyApp());
}

Future<void> _setUpServices() async {
  GetIt.instance.registerSingleton<HttpService>(HttpService());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokémon',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
          useMaterial3: true,
          textTheme: GoogleFonts.permanentMarkerTextTheme(),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
