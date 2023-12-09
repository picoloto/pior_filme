import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pior_filme/pages/dashboard/dashboard_page.dart';
import 'package:pior_filme/pages/movie/movie_list/movie_list_page.dart';
import 'package:pior_filme/pages/home/home_page.dart';

abstract class AppPages {
  static List<GetPage> getPages() => [
        getHomePage(),
      ];

  static List<GetPageRoute> getPageRoutes() => [
        getDashboardPageRoute(),
        getMovieListPageRoute(),
      ];

  static List<String> getPageRoutePaths() =>
      getPageRoutes().map((e) => e.routeName ?? '').toList();

  static GetPage getHomePage() => GetPage(
        name: '/home',
        page: () => const HomePage(),
        binding: HomePageBinding(),
      );

  static GetPageRoute getDashboardPageRoute() => GetPageRoute(
        routeName: '/dashboard',
        page: () => const DashboardPage(),
        binding: DashboardPageBinding(),
      );

  static GetPageRoute getMovieListPageRoute() => GetPageRoute(
        routeName: '/movie_list',
        page: () => const MovieListPage(),
        binding: MovieListPageBinding(),
      );

  static Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == getDashboardPageRoute().routeName) {
      return getDashboardPageRoute();
    }

    if (settings.name == getMovieListPageRoute().routeName) {
      return getMovieListPageRoute();
    }

    return null;
  }
}
