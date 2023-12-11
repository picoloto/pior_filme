import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:pior_filme/models/app/app_page.dart';
import 'package:pior_filme/models/app/theme.dart';
import 'package:pior_filme/models/movie/movie.dart';
import 'package:pior_filme/models/movie/movie_list_dto.dart';
import 'package:pior_filme/models/movie/multiple_winner_list_dto.dart';
import 'package:pior_filme/models/movie/studios_with_win_count_list_dto.dart';
import 'package:pior_filme/models/movie/win_interval_for_producers_list_dto.dart';
import 'package:pior_filme/pages/dashboard/dashboard_page.dart';
import 'package:pior_filme/pages/movie/movie_list/movie_list_page.dart';
import 'package:pior_filme/shared/enums/filter_winner_enum.dart';
import 'package:pior_filme/shared/mocks/interval_win_mock.dart';
import 'package:pior_filme/shared/mocks/movie_mock.dart';
import 'package:pior_filme/shared/mocks/studios_win_mock.dart';
import 'package:pior_filme/shared/mocks/year_winner_mock.dart';
import 'package:pior_filme/shared/utils/api_utils.dart';

void main() {
  test('ApiUtils.convertResponse must convert dynamic in a json', () {
    final Map<String, dynamic> mockResponse = {
      'id': 1,
      'name': 'Test',
    };

    final convertedResponse = ApiUtils.convertResponse(mockResponse);
    expect(convertedResponse, equals(mockResponse));
  });

  test('WinnerFilter extension path must return piece of path', () {
    expect(WinnerFilter.indicated.path, '&winner=false');
    expect(WinnerFilter.winner.path, '&winner=true');
    expect(WinnerFilter.all.path, '');
  });

  test('AppPages.getPagePaths must return all page names', () {
    final pagePaths = AppPages.getPagePaths();

    expect(pagePaths, contains('/home'));
  });

  test('AppPages.getPages must return all pages', () {
    final pages = AppPages.getPages();

    expect(pages.length, equals(1));
    expect(pages[0].name, equals('/home'));
    expect(pages[0].page, isA<Function>());
    expect(pages[0].binding, isA<Bindings>());
  });

  test('AppPages.getTabPages must return all tabPages', () {
    final tabPages = AppPages.getTabPages();

    expect(tabPages.length, equals(2));
    expect(tabPages[0], isA<DashboardPage>());
    expect(tabPages[1], isA<MovieListPage>());
  });

  test('PfTheme.getThemeData must return the app theme', () {
    final themeData = PfTheme.getThemeData();

    expect(themeData.useMaterial3, true);
    expect(themeData.scaffoldBackgroundColor,
        const Color.fromARGB(255, 236, 236, 236));
  });

  test('Movie.fromJson must convert json into a Movie', () {
    final movie = Movie.fromJson(movieMock);

    expect(movie.id, equals(1));
    expect(movie.year, equals(2022));
    expect(movie.title, equals('Sample Movie'));
    expect(movie.studios, equals(['Studio A', 'Studio B']));
    expect(movie.producers, equals(['Producer X', 'Producer Y']));
    expect(movie.winner, equals(true));
  });

  test('Movie.toJson must convert a Movie into a json', () {
    final movie = Movie.fromJson(movieMock);
    final toJsonResult = movie.toJson();

    expect(toJsonResult['id'], equals(1));
    expect(toJsonResult['year'], equals(2022));
    expect(toJsonResult['title'], equals('Sample Movie'));
    expect(toJsonResult['studios'], equals(['Studio A', 'Studio B']));
    expect(toJsonResult['producers'], equals(['Producer X', 'Producer Y']));
    expect(toJsonResult['winner'], equals(true));
  });

  test('MovieListDto.fromJson must convert json into a MovieListDto', () {
    final movieListDto = MovieListDto.fromJson(movieListDtoMock);

    expect(movieListDto.content!.length, equals(1));
    expect(movieListDto.pageable!.pageNumber, equals(0));
    expect(movieListDto.last, equals(true));
  });

  test('MovieListDto.toJson must convert a MovieListDto into a json', () {
    final movieListDto = MovieListDto.fromJson(movieListDtoMock);
    final toJsonResult = movieListDto.toJson();

    expect(toJsonResult['content'].length, equals(1));
    expect(toJsonResult['pageable']['pageNumber'], equals(0));
    expect(toJsonResult['last'], equals(true));
  });

  test('Year.fromJson must convert json into a Year', () {
    final year = Year.fromJson(yearWinnerMock);

    expect(year.year, equals(2022));
    expect(year.winnerCount, equals(5));
  });

  test('Year.toJson must convert a Year into a json', () {
    final year = Year.fromJson(yearWinnerMock);
    final toJsonResult = year.toJson();

    expect(toJsonResult['year'], equals(2022));
    expect(toJsonResult['winnerCount'], equals(5));
  });

  test(
      'MultipleWinnerListDto.fromJson must convert json into a MultipleWinnerListDto',
      () {
    final multipleWinnerListDto =
        MultipleWinnerListDto.fromJson(yearWinnerListDtoMock);

    expect(multipleWinnerListDto.years!.length, equals(1));
    expect(multipleWinnerListDto.years![0].year, equals(2022));
    expect(multipleWinnerListDto.years![0].winnerCount, equals(5));
  });

  test(
      'MultipleWinnerListDto.toJson must convert a MultipleWinnerListDto into a json',
      () {
    final multipleWinnerListDto =
        MultipleWinnerListDto.fromJson(yearWinnerListDtoMock);
    final toJsonResult = multipleWinnerListDto.toJson();

    expect(toJsonResult['years'].length, equals(1));
    expect(toJsonResult['years'][0]['year'], equals(2022));
    expect(toJsonResult['years'][0]['winnerCount'], equals(5));
  });

  test('Studio.fromJson must convert json into a Studio', () {
    final studio = Studio.fromJson(studioMock);

    expect(studio.name, equals('Studio A'));
    expect(studio.winCount, equals(10));
  });

  test('Studio.toJson must convert a Studio into a json', () {
    final studio = Studio.fromJson(studioMock);
    final toJsonResult = studio.toJson();

    expect(toJsonResult['name'], equals('Studio A'));
    expect(toJsonResult['winCount'], equals(10));
  });

  test(
      'StudiosWithWinCountListDto.fromJson must convert json into a StudiosWithWinCountListDto',
      () {
    final studiosWithWinCountListDto =
        StudiosWithWinCountListDto.fromJson(studioWinListDtoMock);

    expect(studiosWithWinCountListDto.studios!.length, equals(1));
    expect(studiosWithWinCountListDto.studios![0].name, equals('Studio A'));
    expect(studiosWithWinCountListDto.studios![0].winCount, equals(10));
  });

  test(
      'StudiosWithWinCountListDto.toJson must convert a StudiosWithWinCountListDto into a json',
      () {
    final studiosWithWinCountListDto =
        StudiosWithWinCountListDto.fromJson(studioWinListDtoMock);
    final toJsonResult = studiosWithWinCountListDto.toJson();

    expect(toJsonResult['studios'].length, equals(1));
    expect(toJsonResult['studios'][0]['name'], equals('Studio A'));
    expect(toJsonResult['studios'][0]['winCount'], equals(10));
  });

  test('IntervalWin.fromJson must convert json into a IntervalWin', () {
    final intervalWin = IntervalWin.fromJson(minIntervalMock);

    expect(intervalWin.producer, equals('Producer A'));
    expect(intervalWin.interval, equals(5));
    expect(intervalWin.previousWin, equals(2000));
    expect(intervalWin.followingWin, equals(2005));
  });

  test('IntervalWin.toJson must convert a IntervalWin into a json', () {
    final intervalWin = IntervalWin.fromJson(minIntervalMock);
    final toJsonResult = intervalWin.toJson();

    expect(toJsonResult['producer'], equals('Producer A'));
    expect(toJsonResult['interval'], equals(5));
    expect(toJsonResult['previousWin'], equals(2000));
    expect(toJsonResult['followingWin'], equals(2005));
  });

  test(
      'WinIntervalForProducersListDto.fromJson must convert json into a WinIntervalForProducersListDto',
      () {
    final winIntervalForProducersListDto =
        WinIntervalForProducersListDto.fromJson(intervalWinDtoMock);

    expect(winIntervalForProducersListDto.min!.length, equals(1));
    expect(winIntervalForProducersListDto.max!.length, equals(1));

    expect(
        winIntervalForProducersListDto.min![0].producer, equals('Producer A'));
    expect(winIntervalForProducersListDto.min![0].interval, equals(5));
    expect(winIntervalForProducersListDto.min![0].previousWin, equals(2000));
    expect(winIntervalForProducersListDto.min![0].followingWin, equals(2005));

    expect(
        winIntervalForProducersListDto.max![0].producer, equals('Producer B'));
    expect(winIntervalForProducersListDto.max![0].interval, equals(10));
    expect(winIntervalForProducersListDto.max![0].previousWin, equals(2000));
    expect(winIntervalForProducersListDto.max![0].followingWin, equals(2010));
  });

  test(
      'WinIntervalForProducersListDto.toJson must convert a WinIntervalForProducersListDto into a json',
      () {
    final winIntervalForProducersListDto =
        WinIntervalForProducersListDto.fromJson(intervalWinDtoMock);
    final toJsonResult = winIntervalForProducersListDto.toJson();

    expect(toJsonResult['min'].length, equals(1));
    expect(toJsonResult['max'].length, equals(1));
  });
}
