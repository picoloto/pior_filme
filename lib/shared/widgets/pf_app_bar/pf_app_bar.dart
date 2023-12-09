import 'package:flutter/material.dart';

class PfAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PfAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        title: const Text(
          'Mobile Flutter Test',
        ),
      ),
    );
  }
}
