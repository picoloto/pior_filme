import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pior_filme/controllers/movie/movie_controller.dart';

class MovieListPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MovieController());
  }
}

class MovieListPage extends GetView<MovieController> {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieController>(
        builder: (MovieController movieController) {
      return Scaffold(
        body: Container(
          color: Colors.amber,
        ),
      );
    });
  }
}
