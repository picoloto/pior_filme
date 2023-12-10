import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pior_filme/controllers/dashboard/dashboard_controller.dart';
import 'package:pior_filme/models/movie/studios_with_win_count_list_dto.dart';
import 'package:pior_filme/shared/widgets/pf_card/pf_card.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_empty_list.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_future_error.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_future_loader.dart';
import 'package:pior_filme/shared/widgets/pf_list_view_separated/pf_list_view_separated.dart';

class StudioWinnersWidget extends StatelessWidget {
  const StudioWinnersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const PfCard(
      title: 'Top 3 studios with winners',
      contentWidget: ContentWidget(),
    );
  }
}

class ContentWidget extends GetView<DashboardController> {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getTopStudiosWithWinCount();

    return GetBuilder<DashboardController>(
      builder: (_) {
        if (controller.topStudiosLoading.value) {
          return const PfFutureLoader();
        }

        if (controller.topStudiosError.value != null) {
          return PfFutureError(
              error: controller.topStudiosError.value as DioException);
        }

        if (controller.topStudios.isEmpty) {
          return const PfEmptyList();
        }

        return PfListViewSeparated(
          itemCount: controller.topStudios.length,
          itemBuilder: (_, index) {
            Studio studio = controller.topStudios[index];

            return ListTile(
              title: Text(studio.name ?? ''),
              leading: const Icon(Icons.theaters_outlined),
              subtitle: Text('${studio.winCount.toString()} wins'),
            );
          },
        );
      },
    );
  }
}
