import 'package:flutter/material.dart';

class PfListViewSeparated extends StatelessWidget {
  final int itemCount;
  final Function(BuildContext, int) itemBuilder;

  const PfListViewSeparated(
      {required this.itemCount, required this.itemBuilder, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: itemCount,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const Divider(
        height: 4,
        indent: 12,
        endIndent: 12,
      ),
      itemBuilder: (_, index) => itemBuilder(_, index),
    );
  }
}
