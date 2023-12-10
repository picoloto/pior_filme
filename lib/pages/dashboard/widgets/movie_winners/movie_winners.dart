import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pior_filme/controllers/dashboard/dashboard_controller.dart';
import 'package:pior_filme/models/movie/movie.dart';
import 'package:pior_filme/shared/widgets/pf_card/pf_card.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_future_error.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_future_loader.dart';
import 'package:pior_filme/shared/widgets/pf_list_view_separated/pf_list_view_separated.dart';

class MovieWinnersWidget extends StatelessWidget {
  final DashboardController dashboardController;
  const MovieWinnersWidget({required this.dashboardController, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: dashboardController.getMovieWinnerByYear(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Movie>> snapshot,
      ) {
        return PfCard(
          title: 'List movie winners by year',
          contentWidget: ContentWidget(
            snapshot: snapshot,
          ),
        );
      },
    );
  }
}

class ContentWidget extends StatelessWidget {
  final AsyncSnapshot<List<Movie>> snapshot;
  const ContentWidget({required this.snapshot, super.key});

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      List<Movie> list = snapshot.data ?? [];

      return Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 6),
            child: TextField(
              onChanged: (t) => {print('t $t')},
              maxLength: 4,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: false,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: "Search for Items",
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: Colors.black,
              ),
            ),
          ),
          PfListViewSeparated(
            itemCount: list.length,
            itemBuilder: (_, index) {
              Movie movie = list[index];

              return ListTile(
                title: Text('${movie.title}'),
                leading: const Icon(Icons.emoji_events_outlined),
                subtitle:
                    Text('ID: ${movie.id}\nYear: ${movie.year.toString()}'),
              );
            },
          ),
        ],
      );
    } else if (snapshot.hasError) {
      return PfFutureError(error: snapshot.error as DioException);
    } else {
      return const PfFutureLoader();
    }
  }
}
