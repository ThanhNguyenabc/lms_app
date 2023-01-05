class ContentItem {
  final List<String>? actions;
  final String? img;
  final List<int>? chartdata;

  ContentItem({this.actions, this.chartdata, this.img});

  factory ContentItem.fromMap(Map<String, dynamic>? map) {
    return ContentItem(
        img: map?["img"],
        actions: List<String>.from(map?["actions"] ?? {}),
        chartdata: List<int>.from(map?["chartdata"] ?? {}));
  }
}

class LessonContent {
  final ContentItem? homework;
  final ContentItem? vocabulary;
  LessonContent({
    this.homework,
    this.vocabulary,
  });

  LessonContent copyWith({
    ContentItem? homework,
    ContentItem? vocabulary,
  }) {
    return LessonContent(
      homework: homework ?? this.homework,
      vocabulary: vocabulary ?? this.vocabulary,
    );
  }

  factory LessonContent.fromMap(Map<String, dynamic> map) {
    return LessonContent(
      homework: ContentItem.fromMap(map['homework']),
      vocabulary: ContentItem.fromMap(map['vocabulary']),
    );
  }
}
