import 'package:intl/intl.dart';
import 'package:lms_app/base/viewmodel/base_viewmodel.dart';
import 'package:lms_app/models/lesson.dart';
import 'package:lms_app/repository/lesson_repository.dart';

class LessonViewModel extends BaseViewModel {
  LessonViewModel({required this.repository});
  final LessonRepository repository;
  List<Lesson> lessons = [];
  int currentLessonIndex = -1;

  void getListLesson() async {
    final currentTime = DateTime.now();
    final nextMonth = currentTime.add(const Duration(days: 30));

    final result = await repository.getListLesson(
        "000101010000", "${DateFormat("yyyyMMdd").format(nextMonth)}0000");

    currentLessonIndex = result.data?.lastIndexWhere(
            (element) => currentTime.compareTo(element.dateStart!) == 1) ??
        -1;

    lessons = result.data?.toList() ?? [];
    notifyListeners();
  }
}
