import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pior_filme/controllers/home/home_controller.dart';
import 'package:pior_filme/models/app/app_page.dart';
import 'package:pior_filme/shared/widgets/pf_app_bar/pf_app_bar.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PfAppBar(),
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: AppPages.getDashboardPageRoute().routeName,
        onGenerateRoute: AppPages.onGenerateRoute,
      ),
      bottomNavigationBar: GetBuilder<HomeController>(
        builder: (_) {
          return BottomNavigationBar(
            currentIndex: controller.tabIndex,
            onTap: controller.changePage,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.movie_outlined),
                label: 'Movie List',
              ),
            ],
          );
        },
      ),
    );
  }
}
