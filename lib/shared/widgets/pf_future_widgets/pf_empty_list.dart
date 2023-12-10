import 'package:flutter/material.dart';

class PfEmptyList extends StatelessWidget {
  final String? customMessage;
  const PfEmptyList({this.customMessage, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Text(customMessage ?? 'No records found'),
      ),
    );
  }
}
