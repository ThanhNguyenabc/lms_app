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
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              item.text,
              style: Theme.of(context).textTheme.bodyLarge,
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

class AssessmentCard extends StatelessWidget {
  const AssessmentCard(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.items});

  final String title;
  final String imagePath;
  final List<Rating> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: Colors.blue.shade800),
        ),
        const SizedBox(
          height: 16,
        ),
        Image.asset(
          imagePath,
          width: double.infinity,
          height: 200,
        ),
        const SizedBox(
          height: 16,
        ),
        ...items
            .map((Rating item) => RatingItem(
                  item: item,
                ))
            .toList()
      ],
    );
  }
}
