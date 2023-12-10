import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pior_filme/controllers/dashboard/dashboard_controller.dart';
import 'package:pior_filme/models/movie/win_interval_for_producers_list_dto.dart';
import 'package:pior_filme/shared/widgets/pf_card/pf_card.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_empty_list.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_future_error.dart';
import 'package:pior_filme/shared/widgets/pf_future_widgets/pf_future_loader.dart';
import 'package:pior_filme/shared/widgets/pf_list_view_separated/pf_list_view_separated.dart';

class ProducerWinsWidget extends StatelessWidget {
  const ProducerWinsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const PfCard(
      title: 'Producers with longest and shorest interval between wins',
      contentWidget: ContentWidget(),
    );
  }
}

class ContentWidget extends GetView<DashboardController> {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getWinIntervalForProducers();

    return GetBuilder<DashboardController>(
      builder: (_) {
        if (controller.winIntervalForProducersLoading.value) {
          return const PfFutureLoader();
        }

        if (controller.winIntervalForProducersError.value != null) {
          return PfFutureError(
            error:
                controller.winIntervalForProducersError.value as DioException,
          );
        }

        if (controller.winIntervalForProducers.value == null) {
          return const PfEmptyList();
        }

        WinIntervalForProducersListDto winIntervalForProducersListDto =
            controller.winIntervalForProducers.value!;
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
      },
    );
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
