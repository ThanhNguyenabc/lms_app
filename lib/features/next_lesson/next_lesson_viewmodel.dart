// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms_app/base/viewmodel/base_viewmodel.dart';
import 'package:lms_app/models/next_lesson.dart';
import 'package:lms_app/repository/lesson_repository.dart';

class NextLessonViewModel extends BaseViewModel {
  NextLessonViewModel({
    required this.repository,
  });

  final LessonRepository repository;
  NextLesson? data;

  Future<void> getNextLesson(String studentId) async {
    setLoading(true);
    final res = await repository.getNextLesson(studentId);
    if (res.data?.lessonId != null && res.data?.seatId != null) {}
    data = res.data;
    setLoading(false);
  }
}
