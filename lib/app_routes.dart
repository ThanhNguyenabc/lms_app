import 'package:flutter/material.dart';
import 'package:lms_app/features/auth/auth_page.dart';
import 'package:lms_app/features/auth/login_page.dart';
import 'package:lms_app/features/lesson/lesson_page.dart';
import 'package:lms_app/features/lesson_detail/lesson_detail_page.dart';
import 'features/dashboard/dashboard_page.dart';

// ignore: non_constant_identifier_names
Map<String, WidgetBuilder> AppRoutes = {
  AuthPage.route: (context) => const AuthPage(),
  LoginPage.route: ((context) => const LoginPage()),
  DashBoardPage.route: ((context) => const DashBoardPage()),
  LessonDetailPage.route: ((context) {
    final params =
        (ModalRoute.of(context)?.settings.arguments as Map<String, String?>);
    return LessonDetailPage(params: params);
  }),
  LessonPage.route: (BuildContext context) => const LessonPage()
};
