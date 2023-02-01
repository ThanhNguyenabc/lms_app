import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lms_app/_widgets/keep_alive.dart';
import 'package:lms_app/features/lesson/lesson_page.dart';
import 'package:lms_app/features/setting/setting_page.dart';
import 'package:lms_app/features/next_lesson/next_lesson_page.dart';
import 'package:lms_app/features/overall_progress/skill_progress_page.dart';

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
  final pageController = PageController();

  final tabs = [
    ScaffoldWithNavBarTabItem(
        icon: const Icon(Icons.home), label: 'Lesson', path: "/lesson"),
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

  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = const [
      KeepAliveWidget(child: LessonPage()),
      KeepAliveWidget(child: SkillProgressPage()),
      KeepAliveWidget(child: NextLessonPage()),
      KeepAliveWidget(child: SettingPage())
    ];
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.only(top: Platform.isAndroid ? 24 : 0),
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: pages,
              ))),
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
      pageController.jumpToPage(index);
      setState(() {
        _currentIndex = index;
      });
    }
  }
}
