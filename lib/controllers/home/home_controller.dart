import 'package:get/get.dart';
import 'package:pior_filme/models/app/app_page.dart';

class HomeController extends GetxController {
  final _tabIndex = 0.obs;

  int get tabIndex => _tabIndex.value;

  set tabIndex(int currentIndex) {
    _tabIndex.value = currentIndex;
    update();
  }

  void changePage(int index) {
    tabIndex = index;
    Get.toNamed(AppPages.getPageRoutePaths()[index], id: 1);
  }
}
