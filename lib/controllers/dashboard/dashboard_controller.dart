import 'dart:async';

import 'package:get/get.dart';
import 'package:pior_filme/models/movie/movie.dart';
import 'package:pior_filme/models/movie/multiple_winner_list_dto.dart';
import 'package:pior_filme/models/movie/studios_with_win_count_list_dto.dart';
import 'package:pior_filme/models/movie/win_interval_for_producers_list_dto.dart';
import 'package:pior_filme/repositories/movie/movie_repository.dart';

class DashboardController extends GetxController {
  final MovieRepository movieRepository = MovieRepository();

  final topStudios = RxList<Studio>();
  final topStudiosLoading = RxBool(true);
  final topStudiosError = Rxn();

  final multipleWinners = RxList<Year>();
  final multipleWinnersLoading = RxBool(true);
  final multipleWinnersError = Rxn();

  final winIntervalForProducers = Rxn<WinIntervalForProducersListDto>();
  final winIntervalForProducersLoading = RxBool(true);
  final winIntervalForProducersError = Rxn();

  final movieWinners = RxList<Movie>();
  final movieWinnersLoading = RxBool(false);
  final movieWinnersError = Rxn();

  Timer? debounce;

  @override
  void onInit() async {
    print('DashboardController');
    super.onInit();
  }

  Future<void> movieYearSearch(String value) async {
    if (debounce != null) {
      debounce!.cancel();
    }

    debounce = Timer(const Duration(seconds: 1), () {
      if (value.isNotEmpty && value.length == 4) {
        getMovieWinnerByYear(year: value);
      } else {
        movieWinners.clear();
        movieWinnersLoading.value = false;
        movieWinnersError.value = null;
        update();
      }
    });
  }

  Future<void> getTopStudiosWithWinCount() async {
    try {
      StudiosWithWinCountListDto data =
          await movieRepository.getStudiosWithWinCount();
      topStudios.clear();

      if (data.studios != null) {
        topStudios.addAll(data.studios!.length > 3
            ? data.studios!.take(3).toList()
            : data.studios!);
      }
    } catch (e) {
      topStudiosError.value = e;
    } finally {
      topStudiosLoading.value = false;
      update();
    }
  }

  Future<void> getMultipleWinners() async {
    try {
      MultipleWinnerListDto data = await movieRepository.getMultipleWinners();
      multipleWinners.clear();

      if (data.years != null) {
        multipleWinners.addAll(data.years!);
      }
    } catch (e) {
      multipleWinnersError.value = e;
    } finally {
      multipleWinnersLoading.value = false;
      update();
    }
  }

  Future<void> getWinIntervalForProducers() async {
    try {
      winIntervalForProducers.value =
          await movieRepository.getWinIntervalForProducers();
    } catch (e) {
      winIntervalForProducersError.value = e;
    } finally {
      winIntervalForProducersLoading.value = false;
      update();
    }
  }

  Future<void> getMovieWinnerByYear({String? year}) async {
    if (year != null) {
      try {
        movieWinnersLoading.value = true;
        update();
        List<Movie> data = await movieRepository.getMovieWinnerByYear(year);
        movieWinners.clear();
        movieWinners.addAll(data);
      } catch (e) {
        movieWinnersError.value = e;
      } finally {
        movieWinnersLoading.value = false;
        update();
      }
    }
  }
}
