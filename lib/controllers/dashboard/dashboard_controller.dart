import 'package:get/get.dart';
import 'package:pior_filme/models/movie/movie.dart';
import 'package:pior_filme/models/movie/multiple_winner_list_dto.dart';
import 'package:pior_filme/models/movie/studios_with_win_count_list_dto.dart';
import 'package:pior_filme/models/movie/win_interval_for_producers_list_dto.dart';
import 'package:pior_filme/repositories/movie/movie_repository.dart';

class DashboardController extends GetxController {
  final MovieRepository movieRepository = MovieRepository();

  @override
  void onInit() async {
    print('DashboardController');
    super.onInit();
  }

  Future<List<Studio>> getTopStudiosWithWinCount() async {
    StudiosWithWinCountListDto data =
        await movieRepository.getStudiosWithWinCount();
    if (data.studios != null && data.studios!.length > 3) {
      return data.studios!.take(3).toList();
    }
    return data.studios ?? [];
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

  Future<List<Movie>> getMovieWinnerByYear({required int year}) async {
    return await movieRepository.getMovieWinnerByYear(year);
  }
}
