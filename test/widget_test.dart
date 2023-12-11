import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:pior_filme/controllers/dashboard/dashboard_controller.dart';
import 'package:pior_filme/controllers/home/home_controller.dart';
import 'package:pior_filme/controllers/movie/movie_controller.dart';
import 'package:pior_filme/pages/dashboard/dashboard_page.dart';
import 'package:pior_filme/pages/dashboard/widgets/movie_winners/movie_winners.dart';
import 'package:pior_filme/pages/dashboard/widgets/multiple_winners/multiple_winners.dart';
import 'package:pior_filme/pages/dashboard/widgets/producer_wins/producer_wins_widget.dart';
import 'package:pior_filme/pages/dashboard/widgets/studio_winners/studio_winners_widget.dart';
import 'package:pior_filme/pages/home/home_page.dart';
import 'package:pior_filme/pages/movie/movie_list/movie_list_page.dart';
import 'package:pior_filme/shared/enums/filter_winner_enum.dart';
import 'package:pior_filme/shared/widgets/pf_app_bar/pf_app_bar.dart';
import 'package:pior_filme/shared/widgets/pf_card/pf_card.dart';
import 'package:pior_filme/shared/widgets/pf_filter/pf_winner_filter.dart';
import 'package:pior_filme/shared/widgets/pf_filter/pf_year_filter.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_empty_list.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_future_error.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_future_loader.dart';
import 'package:pior_filme/shared/widgets/pf_list_view_separated/pf_list_view_separated.dart';

void main() {
  testWidgets('PfAppBar displays a title', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        appBar: PfAppBar(),
      ),
    ));

    expect(find.text('Mobile Flutter Test'), findsOneWidget);
  });

  testWidgets('PfCard displays title and content', (WidgetTester tester) async {
    const String testTitle = 'Test Title';
    const String testContent = 'Test Content';

    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: PfCard(
          title: testTitle,
          contentWidget: Text(testContent),
        ),
      ),
    ));

    expect(find.text(testTitle), findsOneWidget);
    expect(find.text(testContent), findsOneWidget);
  });

  testWidgets('PfWinnerFilter displays a dropdown with WinnerFilter options',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: PfWinnerFilter(
          onChanged: (filter) {},
        ),
      ),
    ));

    final dropdownButtonFinder = find.byType(DropdownMenu<WinnerFilter>);
    expect(dropdownButtonFinder, findsOneWidget);

    await tester.tap(dropdownButtonFinder);
    await tester.pumpAndSettle();

    final noFilterItemFinder = find.text('No').first;
    expect(noFilterItemFinder, findsOneWidget);
  });

  testWidgets('PfYearFilter displays a text input for filter',
      (WidgetTester tester) async {
    String? enteredYear;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: PfYearFilter(
          onChanged: (year) {
            enteredYear = year;
          },
        ),
      ),
    ));

    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);

    await tester.enterText(textFieldFinder, '2023');
    expect(enteredYear, '2023');
  });

  testWidgets('PfEmptyList displays default empty message',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: PfEmptyList(),
      ),
    ));

    expect(find.text('No records found'), findsOneWidget);
  });

  testWidgets('PfEmptyList displays custom empty message',
      (WidgetTester tester) async {
    const String customMessage = 'Custom empty message';

    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: PfEmptyList(customMessage: customMessage),
      ),
    ));

    expect(find.text(customMessage), findsOneWidget);
  });

  testWidgets('PfFutureError displays error type', (WidgetTester tester) async {
    final DioException testError = DioException(
        requestOptions: RequestOptions(path: 'test_endpoint'),
        error: 'Test error message',
        type: DioExceptionType.badResponse);

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: PfFutureError(error: testError),
      ),
    ));

    expect(find.text('Error: DioExceptionType.badResponse'), findsOneWidget);
  });

  testWidgets('PfFutureLoader displays CircularProgressIndicator',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: PfFutureLoader(),
      ),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('PfListViewSeparated displays list of separated widgets',
      (WidgetTester tester) async {
    const int itemCount = 3;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: PfListViewSeparated(
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Item $index'),
            );
          },
        ),
      ),
    ));

    expect(find.byType(ListTile), findsNWidgets(itemCount));
  });

  testWidgets('DashboardPage displays content widgets',
      (WidgetTester tester) async {
    Get.put(DashboardController());

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DashboardPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(MultipleWinnersWidget), findsOneWidget);
    expect(find.byType(StudioWinnersWidget), findsOneWidget);
    expect(find.byType(ProducerWinsWidget), findsOneWidget);
    expect(find.byType(MovieWinnersWidget), findsOneWidget);
  });

  testWidgets('HomePage displays PfAppBar, PageView and BottomNavigationBar',
      (WidgetTester tester) async {
    Get.put(HomeController());
    Get.put(DashboardController());
    Get.put(MovieController());

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: HomePage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(PfAppBar), findsOneWidget);
    expect(find.byType(PageView), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });

  testWidgets('MovieListPage displays PfWinnerFilter and PfYearFilter',
      (WidgetTester tester) async {
    Get.put(MovieController());

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MovieListPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(PfWinnerFilter), findsOneWidget);
    expect(find.byType(PfYearFilter), findsOneWidget);
  });

  testWidgets('MovieWinnersWidget displays PfCard, PfYearFilter and MovieList',
      (WidgetTester tester) async {
    Get.put(DashboardController());

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MovieWinnersWidget(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(PfCard), findsOneWidget);
    expect(find.byType(PfYearFilter), findsOneWidget);
    expect(find.byType(MovieList), findsOneWidget);
  });

  testWidgets('MultipleWinnersWidget displays PfCard',
      (WidgetTester tester) async {
    Get.put(DashboardController());

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MultipleWinnersWidget(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(PfCard), findsOneWidget);
  });

  testWidgets('ProducerWinsWidget displays PfCard',
      (WidgetTester tester) async {
    Get.put(DashboardController());

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProducerWinsWidget(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(PfCard), findsOneWidget);
  });
}
