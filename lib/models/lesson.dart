// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:lms_app/models/Attribute.dart';

class Lesson {
  String? id;
  DateTime? dateStart;
  String? teacherId;
  String? lessonId;
  String? duration;
  String? attendance;
  String? type;
  Attribute? title;
  Lesson({
    this.id,
    this.dateStart,
    this.teacherId,
    this.lessonId,
    this.duration,
    this.attendance,
    this.type,
    this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateStart': dateStart,
      'teacherId': teacherId,
      'lessonId': lessonId,
      'duration': duration,
      'attendance': attendance,
      'type': type,
      'title': title?.toMap(),
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    final lessonInfo =
        map['lesson'] != null ? map['lesson'] as Map<String, dynamic> : null;
    final dateStart =
        map['date_start'] != null ? map['date_start'] as String : null;
    return Lesson(
        id: map['id'] != null ? map['id'] as String : null,
        dateStart: dateStart != null  ? getTimeStart(dateStart) : null ,
        teacherId:
            map['teacher_id'] != null ? map['teacher_id'] as String : null,
        lessonId: map['lesson_id'] != null ? map['lesson_id'] as String : null,
        duration: map['duration'] != null ? map['duration'] as String : null,
        attendance:
            map['attendance'] != null ? map['attendance'] as String : null,
        type: map['type'] != null ? map['type'] as String : null,
        title: Attribute.fromMap(lessonInfo?['title'] ?? {}));
  }

  static DateTime getTimeStart(String dateStart) {
    // raw format yyyyMMddhhmm
    int year = int.parse(dateStart.substring(0, 4));
    int month = int.parse(dateStart.substring(4, 6));
    int day = int.parse(dateStart.substring(6, 8));
    int hour = int.parse(dateStart.substring(8, 10));
    int minute = int.parse(dateStart.substring(10, dateStart.length));
    return DateTime(year, month, day, hour, minute);
  }

  String toJson() => json.encode(toMap());

  factory Lesson.fromJson(String source) =>
      Lesson.fromMap(json.decode(source) as Map<String, dynamic>);
}
