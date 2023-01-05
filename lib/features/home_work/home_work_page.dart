import 'package:flutter/cupertino.dart';
import 'package:lms_app/features/home_work/home_work_card.dart';
import 'package:lms_app/features/lesson/viewmodel/lesson_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeWorkPage extends StatefulWidget {
  const HomeWorkPage({super.key});

  @override
  State<HomeWorkPage> createState() => _HomeWorkPageState();
}

class _HomeWorkPageState extends State<HomeWorkPage> {
  @override
  Widget build(BuildContext context) {
    final lessonList = Provider.of<LessonViewModel>(context).pastLessons;
    print("lesson list");
    print(lessonList.length);
    return PageView.builder(
      itemBuilder: ((context, index) {
        final lesson = lessonList[index];
        return HomeworkCard(
          lesson: lesson,
        );
      }),
      itemCount: lessonList.length,
    );
  }
}
