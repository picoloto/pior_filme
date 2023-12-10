import 'package:flutter/material.dart';

class PfFutureLoader extends StatelessWidget {
  const PfFutureLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
