import 'package:get/get.dart';
import 'package:pior_filme/models/movie/movie.dart';
import 'package:pior_filme/models/movie/multiple_winner_list_dto.dart';
import 'package:pior_filme/models/movie/studios_with_win_count_list_dto.dart';
import 'package:pior_filme/models/movie/win_interval_for_producers_list_dto.dart';
import 'package:pior_filme/repositories/movie/movie_repository.dart';

class DashboardController extends GetxController {
  final MovieRepository movieRepository = MovieRepository();

  final topStudiosWithWinCount = RxList<Studio>();
  final topStudiosLoading = RxBool(true);
  final topStudiosError = Rxn();

  @override
  void onInit() async {
    print('DashboardController');
    super.onInit();
  }

  Future<void> movieYearSearch(String value) async {
    if (value.isNotEmpty && value.length == 4) {
      //  List<ProductsCombined> s = await productList.value;
      // filterProduct = Future.value(s.where((element) => (element.productName.toLowerCase().contains(value.toLowerCase()))).toList()).obs;
      getMovieWinnerByYear(year: value);
    }
    // filterProduct = productList;
  }

  Future<void> getTopStudiosWithWinCount() async {
    try {
      StudiosWithWinCountListDto data =
          await movieRepository.getStudiosWithWinCount();
      topStudiosWithWinCount.clear();

      if (data.studios != null) {
        topStudiosWithWinCount.addAll(data.studios!.length > 3
            ? data.studios!.take(3).toList()
            : data.studios!);
      }
      topStudiosLoading.value = false;
      update();
    } catch (e) {
      topStudiosLoading.value = false;
      topStudiosError.value = e;
      update();
    }
  }

  Future<List<Year>> getMultipleWinners() async {
    MultipleWinnerListDto data = await movieRepository.getMultipleWinners();
    if (data.years != null && data.years!.isNotEmpty) {
      return data.years!;
    }
    return [];
  }

  Future<WinIntervalForProducersListDto> getWinIntervalForProducers() async {
    return await movieRepository.getWinIntervalForProducers();
  }

  Future<List<Movie>> getMovieWinnerByYear({String? year}) async {
    if (year != null) {
      return await movieRepository.getMovieWinnerByYear(year);
    }
    return [];
  }
}
