import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pior_filme/controllers/dashboard/dashboard_controller.dart';
import 'package:pior_filme/models/movie/movie.dart';
import 'package:pior_filme/shared/widgets/pf_card/pf_card.dart';
import 'package:pior_filme/shared/widgets/pf_filter/pf_year_filter.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_empty_list.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_future_error.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_future_loader.dart';
import 'package:pior_filme/shared/widgets/pf_list_view_separated/pf_list_view_separated.dart';

class MovieWinnersWidget extends GetView<DashboardController> {
  const MovieWinnersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PfCard(
      title: 'List movie winners by year',
      contentWidget: Column(
        children: [
          PfYearFilter(onChanged: controller.movieYearSearch),
          const MovieList(),
        ],
      ),
    );
  }
}

class MovieList extends GetView<DashboardController> {
  const MovieList({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getMovieWinnerByYear();

    return GetBuilder<DashboardController>(
      builder: (_) {
        if (controller.movieWinnersLoading.value) {
          return const PfFutureLoader();
        }

        if (controller.movieWinnersError.value != null) {
          return PfFutureError(
            error: controller.movieWinnersError.value as DioException,
          );
        }

        if (controller.movieWinners.isEmpty) {
          return const PfEmptyList(
            customMessage: 'Use the year filter to show records',
          );
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: PfListViewSeparated(
            itemCount: controller.movieWinners.length,
            itemBuilder: (_, index) {
              Movie movie = controller.movieWinners[index];

              return ListTile(
                title: Text('${movie.title}'),
                leading: const Icon(Icons.emoji_events_outlined),
                subtitle:
                    Text('ID: ${movie.id}\nYear: ${movie.year.toString()}'),
              );
            },
          ),
        );
      },
    );
  }
}
