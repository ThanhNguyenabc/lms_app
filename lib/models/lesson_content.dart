class ContentItem {
  final Map<String, String?>? actions;
  final String? img;
  final List<int>? chartdata;

  ContentItem({this.actions, this.chartdata, this.img});

  factory ContentItem.fromMap(Map<String, dynamic>? map) {
    return ContentItem(
        img: map?["img"],
        actions: Map.from(map?["actions"] ?? {}),
        chartdata: List<int>.from(map?["chartdata"] ?? {}));
  }
}

class LessonContent {
  final ContentItem? homework;
  final ContentItem? vocabulary;
  final ContentItem? video;

  LessonContent({this.homework, this.vocabulary, this.video});

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
      video: map["video"] != null ? ContentItem.fromMap(map['video']) : null,
    );
  }
}
