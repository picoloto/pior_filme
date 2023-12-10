import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _tabIndex = 0.obs;
  final pageController = PageController().obs;

  int get tabIndex => _tabIndex.value;

  set tabIndex(int currentIndex) {
    _tabIndex.value = currentIndex;
    update();
  }

  void changePage(int index) {
    tabIndex = index;
    pageController.value.jumpToPage(index);
  }
}
