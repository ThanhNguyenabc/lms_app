import 'package:flutter/material.dart';
import 'package:lms_app/models/lesson_detail.dart';
import 'home_work_item.dart';

class HomeworkCard extends StatelessWidget {
  const HomeworkCard({super.key, required this.lessonDetail});
  final LessonDetail lessonDetail;
  @override
  Widget build(BuildContext context) {
    final content = lessonDetail.content;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Homework",
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: Colors.blue.shade800),
        ),
        const SizedBox(
          height: 12,
        ),
        if (content?.homework != null) ...[
          HomeworkItem(
            title: "Homework",
            imagePath: content?.homework?.img ?? "",
            chartData: content?.homework?.chartdata ?? [],
          ),
          const SizedBox(
            height: 32,
          ),
        ],
        if (content?.vocabulary != null) ...{
          HomeworkItem(
            title: "Vocabulary",
            imagePath: content?.vocabulary?.img ?? "",
            chartData: content?.vocabulary?.chartdata ?? [],
          )
        }
      ],
    );
  }
}
