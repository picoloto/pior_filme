import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pior_filme/controllers/dashboard/dashboard_controller.dart';
import 'package:pior_filme/models/movie/studios_with_win_count_list_dto.dart';
import 'package:pior_filme/shared/widgets/pf_card/pf_card.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_future_error.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_future_loader.dart';
import 'package:pior_filme/shared/widgets/pf_list_view_separated/pf_list_view_separated.dart';

class StudioWinnersWidget extends StatelessWidget {
  final DashboardController dashboardController;
  const StudioWinnersWidget({required this.dashboardController, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Studio>>(
      future: dashboardController.getTopStudiosWithWinCount(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Studio>> snapshot,
      ) {
        return PfCard(
          title: 'Top 3 studios with winners',
          contentWidget: ContentWidget(
            snapshot: snapshot,
          ),
        );
      },
    );
  }
}

class ContentWidget extends StatelessWidget {
  final AsyncSnapshot<List<Studio>> snapshot;
  const ContentWidget({required this.snapshot, super.key});

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      List<Studio> list = snapshot.data ?? [];

      return PfListViewSeparated(
        itemCount: list.length,
        itemBuilder: (_, index) {
          Studio studio = list[index];

          return ListTile(
            title: Text(studio.name ?? ''),
            leading: const Icon(Icons.theaters_outlined),
            subtitle: Text('${studio.winCount.toString()} wins'),
          );
        },
      );
    } else if (snapshot.hasError) {
      return PfFutureError(error: snapshot.error as DioException);
    } else {
      return const PfFutureLoader();
    }
  }
}
