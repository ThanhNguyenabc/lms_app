import 'package:fl_chart/fl_chart.dart';
import 'package:lms_app/base/viewmodel/base_viewmodel.dart';
import 'package:lms_app/models/overall_progress.dart';
import 'package:lms_app/repository/lesson_repository.dart';

class OverallProgressViewModel extends BaseViewModel {
  OverallProgressViewModel({required this.repository});
  final LessonRepository repository;
  CoreSkillPoint? coreSkillPoint;
  List<FlSpot> reading = [];
  List<FlSpot> speaking = [];
  List<FlSpot> writing = [];
  List<FlSpot> listening = [];

  Future<void> getOverallProgress(String studentId) async {
    setLoading(true);
    final res = await repository.getStudentProgress(studentId);
    coreSkillPoint = res.data?.coreSkills;
    speaking = (convertToCoordinate(coreSkillPoint?.speaking ?? []));
    writing = (convertToCoordinate(coreSkillPoint?.writing ?? []));
    reading = (convertToCoordinate(coreSkillPoint?.reading ?? []));
    listening = (convertToCoordinate(coreSkillPoint?.listening ?? []));
    setLoading(false);
  }

  List<FlSpot> convertToCoordinate(List<String?> data) {
    final List<FlSpot> spots = [];
    var preIndexHasValue = 0;
    for (var i = 0; i < data.length; i++) {
      if (data[i] != null) {
        preIndexHasValue = i;
        spots.add(FlSpot(
          i.toDouble(),
          double.parse(data[i]!) * 2,
        ));
      } else {
        spots.add(FlSpot(
          i.toDouble(),
          double.parse(data[preIndexHasValue]!) * 2,
        ));
      }
    }
    print("input");
    print(data);
    print("output");
    print(spots);
    return spots;
  }
}
