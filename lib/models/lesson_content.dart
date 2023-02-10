class ContentItem {
  final Map<String, String?>? actions;
  final String? img;
  final String? charttext;
  final String? chartsubtext;

  final List<int>? chartdata;

  ContentItem({
    this.actions,
    this.chartdata,
    this.img,
    this.charttext,
    this.chartsubtext,
  });

  factory ContentItem.fromMap(Map<String, dynamic>? map) {
    return ContentItem(
        chartsubtext: map?["chartsubtext"],
        charttext: map?["charttext"],
        img: map?["img"],
        actions: Map.from(map?["actions"] ?? {}),
        chartdata: List<int>.from(map?["chartdata"] ?? {}));
  }
}
