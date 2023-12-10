import 'package:flutter/material.dart';
import 'package:pior_filme/shared/enums/filter_winner_enum.dart';

class PfWinnerFilter extends StatelessWidget {
  final Function(WinnerFilter?) onChanged;

  const PfWinnerFilter({required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    final dropDownEntries = [
      const DropdownMenuEntry<WinnerFilter>(
        value: WinnerFilter.all,
        label: 'All',
      ),
      const DropdownMenuEntry<WinnerFilter>(
        value: WinnerFilter.winner,
        label: 'Yes',
      ),
      const DropdownMenuEntry<WinnerFilter>(
        value: WinnerFilter.indicated,
        label: 'No',
      )
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
      child: DropdownMenu<WinnerFilter>(
        initialSelection: WinnerFilter.all,
        onSelected: onChanged,
        dropdownMenuEntries: dropDownEntries,
        label: const Text('Winner?'),
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
