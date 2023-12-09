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
    );
  }
}
