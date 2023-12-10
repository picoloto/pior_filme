import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pior_filme/controllers/movie/movie_controller.dart';
import 'package:pior_filme/models/movie/movie.dart';

class MovieListPage extends GetView<MovieController> {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieController>(
      builder: (MovieController controller) {
        return Scaffold(
          body: ContentWidget(
            controller: controller,
          ),
        );
      },
    );
  }
}

class ContentWidget extends StatelessWidget {
  final MovieController controller;

  const ContentWidget({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return PagedListView(
      pagingController: controller.pagingController,
      shrinkWrap: true,
      padding: const EdgeInsets.all(14),
      builderDelegate: PagedChildBuilderDelegate<Movie>(
        itemBuilder: (context, item, index) => Card(
          child: ListTile(
            title: Text(item.title ?? ''),
            leading: const Icon(Icons.theaters_outlined),
            subtitle: Text(
                'ID: ${item.id}\nYear: ${item.year}\nWinner: ${item.winner == true ? "Yes" : "No"}'),
          ),
        ),
      ),
    );
  }
}
