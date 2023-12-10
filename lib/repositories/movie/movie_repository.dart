import 'package:dio/dio.dart';
import 'package:pior_filme/models/movie/movie.dart';
import 'package:pior_filme/models/movie/movie_list_dto.dart';
import 'package:pior_filme/models/movie/multiple_winner_list_dto.dart';
import 'package:pior_filme/models/movie/studios_with_win_count_list_dto.dart';
import 'package:pior_filme/models/movie/win_interval_for_producers_list_dto.dart';
import 'package:pior_filme/shared/enums/filter_winner_enum.dart';
import 'package:pior_filme/shared/environment/environment.dart';
import 'package:pior_filme/shared/utils/api_utils.dart';

class MovieRepository {
  final dio = Dio();

  Future<MovieListDto> getMoviesList({
    int page = 0,
    required FilterWinner filterWinner,
    int? year,
  }) async {
    try {
      String pagePath = '?page=$page';
      String winnerPath = filterWinner.path;
      String yearPath = year != null ? '&year=$year' : '';

      final response = await dio
          .get('${Environment.apiUrl}$pagePath&size=10$winnerPath$yearPath');

      return MovieListDto.fromJson(ApiUtils.convertResponse(response.data));
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<MultipleWinnerListDto> getMultipleWinners() async {
    try {
      final response = await dio.get(
          '${Environment.apiUrl}${Environment.projectionPath}years-with-multiple-winners');

      return MultipleWinnerListDto.fromJson(
          ApiUtils.convertResponse(response.data));
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<StudiosWithWinCountListDto> getStudiosWithWinCount() async {
    try {
      final response = await dio.get(
          '${Environment.apiUrl}${Environment.projectionPath}studios-with-win-count');

      return StudiosWithWinCountListDto.fromJson(
          ApiUtils.convertResponse(response.data));
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<WinIntervalForProducersListDto> getWinIntervalForProducers() async {
    try {
      final response = await dio.get(
          '${Environment.apiUrl}${Environment.projectionPath}max-min-win-interval-for-producers');

      return WinIntervalForProducersListDto.fromJson(
          ApiUtils.convertResponse(response.data));
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<Movie>> getMovieWinnerByYear(String year) async {
    try {
      String yearPath = '&year=$year';

      final response =
          await dio.get('${Environment.apiUrl}?winner=true$yearPath');

      Iterable list = ApiUtils.convertResponse(response.data);
      return list.map((model) => Movie.fromJson(model)).toList();
    } catch (e) {
      return Future.error(e);
    }
  }
}
