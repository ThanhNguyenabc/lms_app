import 'package:flutter/material.dart';

class SlidingCard extends StatelessWidget {
  const SlidingCard({super.key, required this.content});
  final Widget content;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      child: content,
    );
  }
}
