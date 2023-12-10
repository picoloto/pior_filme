import 'dart:async';

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

  int _pageIndex = 0;
  String? _yearFilter;
  WinnerFilter _winnerFilter = WinnerFilter.all;

  Timer? _debounceTimerYearFilter;

  Future<void> yearFilter(String value) async {
    if (_debounceTimerYearFilter != null) {
      _debounceTimerYearFilter!.cancel();
    }

    _debounceTimerYearFilter = Timer(
      const Duration(seconds: 1),
      () {
        _pageIndex = 0;
        _yearFilter = value.isNotEmpty && value.length == 4 ? value : null;
        pagingController.refresh();
      },
    );
  }

  Future<void> winnerFilter(WinnerFilter? value) async {
    if (value != null) {
      _winnerFilter = value;
      pagingController.refresh();
    }
  }

  void addPageScrollerListner() {
    pagingController.addPageRequestListener((pageKey) {
      _pageIndex = pageKey;
      _getMovieListPaginated();
    });
  }

  Future<void> _getMovieListPaginated() async {
    try {
      MovieListDto data = await movieRepository.getMoviesList(
        page: _pageIndex,
        filterWinner: _winnerFilter,
        year: _yearFilter,
      );

      if (data.content != null && data.content!.isNotEmpty) {
        final isLastPage = data.last!;
        if (isLastPage) {
          pagingController.appendLastPage(data.content!);
        } else {
          final nextPageKey = _pageIndex + 1;
          pagingController.appendPage(data.content!, nextPageKey);
        }
      }
    } catch (error) {
      pagingController.error = error;
    }
  }
}
