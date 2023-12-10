import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PfFutureError extends StatelessWidget {
  final DioException error;
  const PfFutureError({required this.error, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Text('Error: ${error.type.toString()}'),
      ),
    );
  }
}
