import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pior_filme/models/movie/movie.dart';
import 'package:pior_filme/models/movie/movie_list_dto.dart';
import 'package:pior_filme/repositories/movie/movie_repository.dart';
import 'package:pior_filme/shared/enums/filter_winner_enum.dart';

class MovieController extends GetxController {
  final MovieRepository movieRepository = MovieRepository();
  final PagingController<int, Movie> pagingController =
      PagingController(firstPageKey: 0);

  @override
  void onInit() {
    print('MovieController');
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.onInit();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      MovieListDto data = await movieRepository.getMoviesList(
          page: pageKey, filterWinner: FilterWinner.all);
      if (data.content != null && data.content!.isNotEmpty) {
        final isLastPage = data.last!;
        if (isLastPage) {
          pagingController.appendLastPage(data.content!);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(data.content!, nextPageKey);
        }
      }
    } catch (error) {
      pagingController.error = error;
    }
  }
}
