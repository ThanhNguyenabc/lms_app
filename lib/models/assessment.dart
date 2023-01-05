import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CoreSkill {
  final String? reading;
  final String? speaking;
  final String? listening;
  final String? writing;
  CoreSkill({
    required this.reading,
    required this.speaking,
    required this.listening,
    required this.writing,
  });

  factory CoreSkill.fromMap(Map<String, dynamic> map) {
    return CoreSkill(
      reading: map['Reading'] != null ? map['Reading'] as String : null,
      speaking: map['Speaking'] != null ? map['Speaking'] as String : null,
      listening: map['Listening'] != null ? map['Listening'] as String : null,
      writing: map['Writing'] != null ? map['Writing'] as String : null,
    );
  }
}

class Assessment {
  final List<String>? teacherfeedback;
  final CoreSkill? coreSkill;
  final Map<String, dynamic>? outcomes;
  Assessment(
      {required this.teacherfeedback,
      required this.coreSkill,
      required this.outcomes});

  factory Assessment.fromMap(Map<String, dynamic> map) {
    final coreSkill = map['coreskills'] as Map<String, dynamic>?;
    final outcomes = map['outcomes'] as Map<String, dynamic>?;

    return Assessment(
        teacherfeedback: List<String>.from((map['teacherfeedback'])),
        coreSkill: CoreSkill.fromMap(coreSkill ?? {}),
        outcomes: outcomes ?? {});
  }

  @override
  String toString() =>
      'Assessment(teacherfeedback: $teacherfeedback, coreSkill: $coreSkill, outcomes: $outcomes)';

  @override
  bool operator ==(covariant Assessment other) {
    if (identical(this, other)) return true;

    return listEquals(other.teacherfeedback, teacherfeedback) &&
        other.coreSkill == coreSkill &&
        mapEquals(other.outcomes, outcomes);
  }

  @override
  int get hashCode =>
      teacherfeedback.hashCode ^ coreSkill.hashCode ^ outcomes.hashCode;
}
