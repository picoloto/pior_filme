import 'package:get/get.dart';
import 'package:pior_filme/repositories/movie/movie_repository.dart';
import 'package:pior_filme/shared/enums/filter_winner_enum.dart';

class DashboardController extends GetxController {
  final MovieRepository movieRepository = MovieRepository();

  @override
  void onInit() async {
    print('DashboardController');
    // print(await movieRepository.getMoviesList(
    //     page: 0, filterWinner: FilterWinner.indicated));
    // print(await movieRepository.getMultipleWinners());
    print(await movieRepository.getStudiosWithWinCount());
    // print(await movieRepository.getWinIntervalForProducers());
    // print(await movieRepository.getMovieWinnerByYear(2015));
    super.onInit();
  }
}
