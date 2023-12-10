import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pior_filme/controllers/dashboard/dashboard_controller.dart';
import 'package:pior_filme/models/movie/win_interval_for_producers_list_dto.dart';
import 'package:pior_filme/shared/widgets/pf_card/pf_card.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_future_error.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_future_loader.dart';
import 'package:pior_filme/shared/widgets/pf_list_view_separated/pf_list_view_separated.dart';

class ProducerWinsWidget extends StatelessWidget {
  final DashboardController dashboardController;
  const ProducerWinsWidget({required this.dashboardController, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WinIntervalForProducersListDto>(
      future: dashboardController.getWinIntervalForProducers(),
      builder: (
        BuildContext context,
        AsyncSnapshot<WinIntervalForProducersListDto> snapshot,
      ) {
        return PfCard(
          title: 'Producers with longest and shorest interval between wins',
          contentWidget: ContentWidget(
            snapshot: snapshot,
          ),
        );
      },
    );
  }
}

class ContentWidget extends StatelessWidget {
  final AsyncSnapshot<WinIntervalForProducersListDto> snapshot;
  const ContentWidget({required this.snapshot, super.key});

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      WinIntervalForProducersListDto winIntervalForProducersListDto =
          snapshot.data!;
      List<IntervalWin> maxList = winIntervalForProducersListDto.max ?? [];
      List<IntervalWin> minList = winIntervalForProducersListDto.min ?? [];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProducerWinsTitle(title: 'Maximum'),
          ProducerWinsList(list: maxList),
          const Divider(
            height: 4,
            indent: 12,
            endIndent: 12,
          ),
          const ProducerWinsTitle(title: 'Minimum'),
          ProducerWinsList(
            list: minList,
            showPadding: true,
          ),
        ],
      );
    } else if (snapshot.hasError) {
      return PfFutureError(error: snapshot.error as DioException);
    } else {
      return const PfFutureLoader();
    }
  }
}

class ProducerWinsTitle extends StatelessWidget {
  final String title;
  const ProducerWinsTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    );
  }
}

class ProducerWinsList extends StatelessWidget {
  final List<IntervalWin> list;
  final bool showPadding;

  const ProducerWinsList({
    required this.list,
    this.showPadding = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: showPadding ? const EdgeInsets.only(bottom: 6) : EdgeInsets.zero,
      child: PfListViewSeparated(
        itemCount: list.length,
        itemBuilder: (_, index) {
          IntervalWin item = list[index];

          return ListTile(
            title: Text(item.producer.toString()),
            leading: const Icon(Icons.military_tech_outlined),
            subtitle: Text(
                'Interval: ${item.interval}\nPrevious Year: ${item.previousWin}\nFollowing Year: ${item.followingWin}'),
          );
        },
      ),
    );
  }
}
