import 'package:flutter/material.dart';

abstract class PfTheme {
  static getThemeData() => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 236, 236, 236),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        appBarTheme: AppBarTheme(
          color: Colors.deepPurple[400],
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.deepPurple[400],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
