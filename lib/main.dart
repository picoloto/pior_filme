import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:pior_filme/models/app/app_page.dart';

void main() {
  runApp(const PiorFilmeApp());
}

class PiorFilmeApp extends StatelessWidget {
  const PiorFilmeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pior Filme',
      debugShowCheckedModeBanner: false,
      getPages: AppPages.getPages(),
      initialRoute: AppPages.getHomePage().name,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      theme: ThemeData(
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
      ),
    );
  }
}
