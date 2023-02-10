import 'assessment.dart';
import 'lesson_content.dart';

class LessonDetail {
  final Map<String, ContentItem?>? content;
  final Assessment? assessment;

  LessonDetail({
    required this.content,
    required this.assessment,
  });

  factory LessonDetail.fromMap(Map<String, dynamic> map) {
    final content = Map.from(map["content"] ?? {}).map((key, value) =>
        MapEntry<String, ContentItem>(key, ContentItem.fromMap(value)));
    final res = LessonDetail(
      content: content,
      assessment: Assessment.fromMap(map['assessment']),
    );
    return res;
  }
}
