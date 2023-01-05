import 'assessment.dart';
import 'lesson_content.dart';

class LessonDetail {
  final LessonContent? content;
  final Assessment? assessment;
  LessonDetail({
    required this.content,
    required this.assessment,
  });

  LessonDetail copyWith({
    LessonContent? content,
    Assessment? assessment,
  }) {
    return LessonDetail(
      content: content ?? this.content,
      assessment: assessment ?? this.assessment,
    );
  }

  factory LessonDetail.fromMap(Map<String, dynamic> map) {
    final res = LessonDetail(
      content: LessonContent.fromMap(map['content']),
      assessment: Assessment.fromMap(map['assessment']),
    );
    return res;
  }
}
