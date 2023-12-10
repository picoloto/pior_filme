import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pior_filme/controllers/dashboard/dashboard_controller.dart';
import 'package:pior_filme/models/movie/multiple_winner_list_dto.dart';
import 'package:pior_filme/shared/widgets/pf_card/pf_card.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_future_error.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_future_loader.dart';
import 'package:pior_filme/shared/widgets/pf_list_view_separated/pf_list_view_separated.dart';

class MultipleWinnersWidget extends StatelessWidget {
  final DashboardController dashboardController;
  const MultipleWinnersWidget({required this.dashboardController, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Year>>(
      future: dashboardController.getMultipleWinners(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Year>> snapshot,
      ) {
        return PfCard(
          title: 'List years with multiple winners',
          contentWidget: ContentWidget(
            snapshot: snapshot,
          ),
        );
      },
    );
  }
}

class ContentWidget extends StatelessWidget {
  final AsyncSnapshot<List<Year>> snapshot;
  const ContentWidget({required this.snapshot, super.key});

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      List<Year> list = snapshot.data ?? [];

      return PfListViewSeparated(
        itemCount: list.length,
        itemBuilder: (_, index) {
          Year year = list[index];

          return ListTile(
            title: Text(year.year.toString()),
            leading: const Icon(Icons.movie_filter_outlined),
            subtitle: Text('${year.winnerCount.toString()} winners'),
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
