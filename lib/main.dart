import 'package:audio_player/screens/home_page.dart';
import 'package:audio_player/screens/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        'HomePage': (context) => const HomePage(),
      },
    ),
  );
}
