import 'package:flutter/material.dart';
import 'package:lms_app/_widgets/loading.dart';
import 'package:lms_app/base/view/base_view.dart';
import 'package:lms_app/features/lesson_detail/lesson_detail_viewmodel.dart';
import 'package:lms_app/models/lesson.dart';
import 'package:lms_app/service_locator.dart';
import 'package:lms_app/utils/date_util.dart';
import 'package:provider/provider.dart';

import 'home_work_item.dart';

class HomeworkCard extends StatelessWidget {
  const HomeworkCard({super.key, required this.lesson});
  final Lesson lesson;
  @override
  Widget build(BuildContext context) {
    final lessonDetailViewModel = getIt.get<LessonDetailViewModel>();
    return BaseView(
      vmBuilder: (_) => lessonDetailViewModel,
      builder: ((p0) {
        lessonDetailViewModel.getLessonDetail(lesson.id!);
        print("lesson id");
        print(lesson.id);
        return Consumer(
          builder: ((BuildContext context, LessonDetailViewModel viewModel,
              Widget? child) {
            final content = viewModel.lessonDetail?.content;
            if (content != null) {
              return Container(
                color: Colors.grey.shade200,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 4,
                    ),
                    Text(
                      "Lesson: ${lesson.title?.en ?? "unknown"}",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Time: ${formatLessonDate(lesson.dateStart!)}",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    if (content.homework != null) ...[
                      HomeworkItem(
                        title: "Homework",
                        imagePath: content.homework?.img ?? "",
                        chartData: content.homework?.chartdata ?? [],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                    ],
                    if (content.vocabulary != null) ...{
                      HomeworkItem(
                        title: "Vocabulary",
                        imagePath: content.vocabulary?.img ?? "",
                        chartData: content.vocabulary?.chartdata ?? [],
                      )
                    }
                  ],
                ),
              );
            }
            return child!;
          }),
          child: const Loading(),
        );
      }),
    );
  }
}
