import 'package:intl/intl.dart';
import 'package:lms_app/base/viewmodel/base_viewmodel.dart';
import 'package:lms_app/models/lesson.dart';
import 'package:lms_app/repository/lesson_repository.dart';

class LessonViewModel extends BaseViewModel {
  LessonViewModel({required this.repository});
  final LessonRepository repository;
  List<Lesson> pastLessons = [];

  void getPastLesson() async {
    final currentDate = DateFormat("yyyyMMdd")
        .format(DateTime.now().subtract(const Duration(days: 1)));

    final result =
        await repository.getListLesson("000101010000", "${currentDate}0000");
    pastLessons = result.data?.reversed.toList() ?? [];
    notifyListeners();
  }
}
