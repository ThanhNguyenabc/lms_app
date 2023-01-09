import 'package:flutter/material.dart';
import 'package:lms_app/_widgets/keep_alive.dart';
import 'package:lms_app/base/view/base_view.dart';
import 'package:lms_app/features/home_work/home_work_page.dart';
import 'package:lms_app/features/lesson/lesson_page.dart';
import 'package:lms_app/features/lesson/viewmodel/lesson_viewmodel.dart';
import 'package:lms_app/features/setting/setting_page.dart';
import 'package:lms_app/features/next_lesson/next_lesson_page.dart';
import 'package:lms_app/features/overall_progress/skill_progress_page.dart';
import 'package:lms_app/service_locator.dart';

class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  ScaffoldWithNavBarTabItem(
      {required super.icon, required this.path, super.label});
  final String path;
}

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({
    super.key,
  });
  static const route = "/dashboard";

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int _currentIndex = 0;

  final tabs = [
    ScaffoldWithNavBarTabItem(
        icon: const Icon(Icons.home), label: 'Lesson', path: "/lesson"),
    ScaffoldWithNavBarTabItem(
        icon: const Icon(Icons.home_work),
        label: 'Homework',
        path: "/homework"),
    ScaffoldWithNavBarTabItem(
        icon: const Icon(Icons.area_chart),
        label: ' Progress',
        path: "/progress"),
    ScaffoldWithNavBarTabItem(
        icon: const Icon(Icons.next_plan),
        label: 'NextLesson',
        path: "/progress"),
    ScaffoldWithNavBarTabItem(
        icon: const Icon(Icons.settings), label: 'Setting', path: "/setting")
  ];

  final pages = const [
    KeepAliveWidget(child: LessonPage()),
    HomeWorkPage(),
    SkillProgressPage(),
    NextLessonPage(),
    SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    print("dashboard page");
    return Scaffold(
      body: SafeArea(
          child: KeepAliveWidget(
        child: BaseView(
          vmBuilder: (p0) => getIt.get<LessonViewModel>(),
          builder: (p0) => pages[_currentIndex],
        ),
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: tabs,
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) => _onItemTapped(context, index),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }
}
