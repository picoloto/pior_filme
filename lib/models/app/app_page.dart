import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pior_filme/pages/dashboard/dashboard_page.dart';
import 'package:pior_filme/pages/movie/movie_list/movie_list_page.dart';
import 'package:pior_filme/pages/home/home_page.dart';

abstract class AppPages {
  static List<GetPage> getPages() => [getHomePage()];

  static List<Widget> getTabPages() => [
        const DashboardPage(),
        const MovieListPage(),
      ];

  static List<String> getPagePaths() => getPages().map((e) => e.name).toList();

  static GetPage getHomePage() => GetPage(
        name: '/home',
        page: () => const HomePage(),
        binding: HomePageBinding(),
      );
}
