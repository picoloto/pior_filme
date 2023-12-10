import 'package:flutter/material.dart';

class PfYearFilter extends StatelessWidget {
  final Function(String) onChanged;

  const PfYearFilter({required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: TextField(
        onChanged: onChanged,
        maxLength: 4,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          label: const Text('Year'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: "Search by year",
          prefixIcon: const Icon(Icons.search),
          counter: const SizedBox.shrink(),
        ),
      ),
    );
  }
}
