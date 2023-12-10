import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pior_filme/controllers/dashboard/dashboard_controller.dart';
import 'package:pior_filme/pages/dashboard/widgets/movie_winners/movie_winners.dart';
import 'package:pior_filme/pages/dashboard/widgets/multiple_winners/multiple_winners.dart';
import 'package:pior_filme/pages/dashboard/widgets/producer_wins/producer_wins_widget.dart';
import 'package:pior_filme/pages/dashboard/widgets/studio_winners/studio_winners_widget.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (DashboardController controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                MultipleWinnersWidget(dashboardController: controller),
                StudioWinnersWidget(dashboardController: controller),
                ProducerWinsWidget(dashboardController: controller),
                MovieWinnersWidget(dashboardController: controller),
              ],
            ),
          ),
        );
      },
    );
  }
}
