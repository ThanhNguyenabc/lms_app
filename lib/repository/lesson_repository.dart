import 'package:lms_app/api/app_dio.dart';
import 'package:lms_app/models/lesson.dart';
import 'package:lms_app/models/lesson_detail.dart';
import 'package:lms_app/models/next_lesson.dart';
import 'package:lms_app/models/overall_progress.dart';
import 'package:lms_app/models/result.dart';
import 'package:lms_app/service_locator.dart';

class LessonRepository {
  Map<String, dynamic> lessonCacheMap = {};

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
        transform: ((data) => List<Lesson>.from(data.map((e) {
              final lesson = Lesson.fromMap(e);
              lessonCacheMap[lesson.id!] = {
                "title": lesson.title,
                "date": lesson.dateStart
              };
              return lesson;
            }))));
    return res;
  }

  Future<Result<LessonDetail>> getLessonDetail(String lessonId) async {
    final lessonDetail = lessonCacheMap[lessonId]?["detail"];

    if (lessonDetail != null) {
      return Result.success(lessonDetail);
    }

    final res = await getIt<AppDio>().post<LessonDetail>(
        params: {"f": "Api_Get_Lesson_Detail"},
        data: {"seat_id": lessonId},
        transform: ((data) {
          final lessonDetail = LessonDetail.fromMap(data);
          final lessonCacheItem = lessonCacheMap[lessonId];
          lessonCacheMap[lessonId] = {
            ...lessonCacheItem,
            "detail": lessonDetail
          };
          return lessonDetail;
        }));
    return res;
  }

  Future<Result<OverallProgress>> getStudentProgress(String studentId) async {
    final res = await getIt<AppDio>().post<OverallProgress>(
        params: {"f": "Api_Get_Progress"},
        data: {"student_id": studentId},
        transform: ((data) {
          final progressData = OverallProgress.fromMap(data);

          return progressData;
        }));
    return res;
  }

  Future<Result<NextLesson>> getNextLesson(String studentId) async {
    final res = await getIt<AppDio>().post<NextLesson>(
        params: {"f": "Api_Get_Next_Lesson"},
        data: {"student_id": studentId},
        transform: ((data) => NextLesson.fromMap(data)));
    return res;
  }
}
