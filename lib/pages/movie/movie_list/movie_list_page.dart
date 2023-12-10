import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pior_filme/controllers/movie/movie_controller.dart';
import 'package:pior_filme/models/movie/movie.dart';
import 'package:pior_filme/shared/widgets/pf_filter/pf_winner_filter.dart';
import 'package:pior_filme/shared/widgets/pf_filter/pf_year_filter.dart';

class MovieListPage extends GetView<MovieController> {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 0,
                child: PfWinnerFilter(onChanged: controller.winnerFilter),
              ),
              Expanded(
                child: PfYearFilter(onChanged: controller.yearFilter),
              ),
            ],
          ),
          const ContentWidget(),
        ],
      ),
    );
  }
}

class ContentWidget extends GetView<MovieController> {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    controller.addPageScrollerListner();
    return GetBuilder<MovieController>(
      builder: (_) {
        return Expanded(
          child: PagedListView(
            pagingController: controller.pagingController,
            shrinkWrap: true,
            padding: const EdgeInsets.all(14),
            builderDelegate: PagedChildBuilderDelegate<Movie>(
              itemBuilder: (context, item, index) => Card(
                color: Colors.white,
                child: ListTile(
                  title: Text(item.title ?? ''),
                  leading: const Icon(Icons.theaters_outlined),
                  subtitle: Text(
                      'ID: ${item.id}\nYear: ${item.year}\nWinner: ${item.winner == true ? "Yes" : "No"}'),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
