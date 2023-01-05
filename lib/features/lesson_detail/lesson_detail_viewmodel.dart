// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms_app/base/viewmodel/base_viewmodel.dart';
import 'package:lms_app/models/lesson_detail.dart';

import '../../repository/lesson_repository.dart';

class LessonDetailViewModel extends BaseViewModel {
  LessonDetailViewModel({
    required this.repository,
  });
  final LessonRepository repository;
  LessonDetail? lessonDetail;
  Map<String, LessonDetail?> lessonDetailMap = {};

  Future<void> getLessonDetail(String id) async {
    final result = await repository.getLessonDetail(id);
    lessonDetail = result.data;

    if (result.data != null) {
      lessonDetailMap[id] = result.data!;
    }
    notifyListeners();
  }
}
