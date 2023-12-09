import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pior_filme/controllers/dashboard/dashboard_controller.dart';

class DashboardPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
  }
}

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (DashboardController controller) {
        return Scaffold(
          body: Container(
            color: Colors.blue,
          ),
        );
      },
    );
  }
}
