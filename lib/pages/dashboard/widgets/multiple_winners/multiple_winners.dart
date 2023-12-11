import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pior_filme/controllers/dashboard/dashboard_controller.dart';
import 'package:pior_filme/models/movie/multiple_winner_list_dto.dart';
import 'package:pior_filme/shared/widgets/pf_card/pf_card.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_empty_list.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_future_error.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_future_loader.dart';
import 'package:pior_filme/shared/widgets/pf_list_view_separated/pf_list_view_separated.dart';

class MultipleWinnersWidget extends StatelessWidget {
  const MultipleWinnersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const PfCard(
      title: 'List years with multiple winners',
      contentWidget: ContentWidget(),
    );
  }
}

class ContentWidget extends GetView<DashboardController> {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getMultipleWinners();

    return GetBuilder<DashboardController>(
      builder: (_) {
        if (controller.multipleWinnersLoading.value) {
          return const PfFutureLoader();
        }

        if (controller.multipleWinnersError.value != null) {
          return PfFutureError(
            error: controller.multipleWinnersError.value as DioException,
          );
        }

        if (controller.multipleWinners.isEmpty) {
          return const PfEmptyList();
        }

        return PfListViewSeparated(
          itemCount: controller.multipleWinners.length,
          itemBuilder: (_, index) {
            Year year = controller.multipleWinners[index];

            return ListTile(
              title: Text(year.year.toString()),
              leading: const Icon(Icons.movie_filter_outlined),
              subtitle: Text('${year.winnerCount.toString()} winners'),
            );
          },
        );
      },
    );
  }
}
