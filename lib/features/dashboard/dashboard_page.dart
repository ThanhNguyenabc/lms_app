import 'package:flutter/material.dart';
import 'package:lms_app/_widgets/keep_alive.dart';
import 'package:lms_app/features/lesson/lesson_page.dart';
import 'package:lms_app/features/lesson_detail/lesson_detail_page.dart';
import 'package:lms_app/features/setting/setting_page.dart';
import 'package:lms_app/features/overall_progress/progress_page.dart';

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

  final tabs = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Lesson'),
    BottomNavigationBarItem(icon: Icon(Icons.area_chart), label: ' Progress'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting')
  ];

  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      KeepAliveWidget(
        child: Navigator(
          onGenerateRoute: (settings) {
            Widget page = const LessonPage();
            if (settings.name == LessonDetailPage.route) {
              final params = (settings.arguments as Map<String, String?>);
              page = LessonDetailPage(params: params);
            }
            return MaterialPageRoute(builder: (_) => page);
          },
        ),
      ),
      const KeepAliveWidget(child: ProgressPage()),
      const KeepAliveWidget(child: SettingPage())
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
          child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
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
      pageController.jumpToPage(index);
      setState(() {
        _currentIndex = index;
      });
    }
  }
}
