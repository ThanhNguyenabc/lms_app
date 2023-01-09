class NextLesson {
  String? lessonId;
  String? seatId;
  String? subtitle;
  String? dateIn;
  String? date;
  String? time;
  String? teacher;
  String? aimIntro;
  List<String>? aims;

  NextLesson({
    this.lessonId,
    this.seatId,
    this.subtitle,
    this.dateIn,
    this.date,
    this.time,
    this.teacher,
    this.aimIntro,
    this.aims,
  });

  bool isHasData() =>
      lessonId != null &&
      seatId != null &&
      subtitle != null &&
      dateIn != null &&
      date != null &&
      dateIn != null;
      
  factory NextLesson.fromMap(Map<String, dynamic> map) {
    return NextLesson(
      lessonId: map['lesson_id'] != null ? map['lesson_id'] as String : null,
      seatId: map['seat_id'] != null ? map['seat_id'] as String : null,
      subtitle: map['subtitle'] != null ? map['subtitle'] as String : null,
      dateIn: map['date-in'] != null ? map['date-in'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      teacher: map['teacher'] != null ? map['teacher'] as String : null,
      aimIntro: map['aim-intro'] != null ? map['aim-intro'] as String : null,
      aims: map['aims'] != null ? List<String>.from((map['aims'])) : null,
    );
  }
}
