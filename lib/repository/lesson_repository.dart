import 'package:lms_app/api/app_dio.dart';
import 'package:lms_app/models/lesson.dart';
import 'package:lms_app/models/result.dart';
import 'package:lms_app/service_locator.dart';

class LessonRepository {
  Future<Result<List<Lesson>>> getListLesson(
      String fromDate, String toDate) async {
    final res = await getIt<AppDio>().post<List<Lesson>>(
        params: {
          "f": "Class_Seats_ListByStudent"
        },
        data: {
          "date_from": fromDate,
          "date_to": toDate,
          "options": {"lesson": true, "marknext": true}
        },
        transform: ((data) =>
            List<Lesson>.from(data.map((e) => Lesson.fromMap(e)))));
    return res;
  }

  Future<Result<List<Lesson>>> getLessonContent(String seatId) async {
    final res = await getIt<AppDio>().post<List<Lesson>>(
        params: {"f": "Api_Get_Lesson_Content"},
        data: {"sead_id": seatId},
        transform: ((data) =>
            List<Lesson>.from(data.map((e) => Lesson.fromMap(e)))));
    return res;
  }
}
