import 'package:lms_app/base/viewmodel/base_viewmodel.dart';
import 'package:lms_app/models/lesson.dart';
import 'package:lms_app/repository/lesson_repository.dart';

class LessonViewModel extends BaseViewModel {
  LessonViewModel({required this.repository});
  final LessonRepository repository;
  List<Lesson> pastLessons = [];

  void getPastLesson() async {
    final result =
        await repository.getListLesson("000101010000", "202212220000");
    print("lesson id ");
    print(result.data?[0].lessonId);
    pastLessons = result.data?.reversed.toList() ?? [];
    notifyListeners();
  }
}
