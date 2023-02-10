// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Rating {
  final int rate;
  final String text;
  Rating({
    required this.rate,
    required this.text,
  });
}

class RatingItem extends StatelessWidget {
  const RatingItem({super.key, required this.item});
  final Rating item;
  @override
  Widget build(BuildContext context) {
    final starItem = [];
    for (var i = 1; i <= 5; i++) {
      if (i <= item.rate) {
        starItem.add(
          const Icon(Icons.star),
        );
      } else {
        starItem.add(
          const Icon(Icons.star_border),
        );
      }
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              item.text,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          ...starItem
        ],
      ),
    );
  }
}
