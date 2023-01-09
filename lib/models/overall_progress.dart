class CoreSkillPoint {
  List<String?>? reading;
  List<String?>? speaking;
  List<String?>? listening;
  List<String?>? writing;
  CoreSkillPoint({
    this.reading,
    this.speaking,
    this.listening,
    this.writing,
  });

  factory CoreSkillPoint.fromMap(Map<String, dynamic> map) {
    return CoreSkillPoint(
      reading:
          map['reading'] != null ? List<String?>.from((map['reading'])) : null,
      speaking: map['speaking'] != null
          ? List<String?>.from((map['speaking']))
          : null,
      listening: map['listening'] != null
          ? List<String?>.from((map['listening']))
          : null,
      writing:
          map['writing'] != null ? List<String?>.from((map['writing'])) : null,
    );
  }
}

class OverallProgress {
  List<String>? overall;
  CoreSkillPoint? coreSkills;
  OverallProgress({
    this.overall,
    this.coreSkills,
  });

  factory OverallProgress.fromMap(Map<String, dynamic> map) {
    return OverallProgress(
        overall:
            map['overall'] != null ? List<String>.from((map['overall'])) : null,
        coreSkills: map["core-skills"] != null
            ? CoreSkillPoint.fromMap(map["core-skills"])
            : null);
  }
}
