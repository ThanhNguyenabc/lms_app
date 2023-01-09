import 'package:flutter/material.dart';
import 'package:lms_app/features/auth/auth_page.dart';
import 'package:lms_app/features/auth/login_page.dart';
import 'package:lms_app/features/lesson/lesson_page.dart';
import 'package:lms_app/features/lesson_detail/lesson_detail_page.dart';

import 'features/dashboard/dashboard_page.dart';

Map<String, WidgetBuilder> appRoutes() => {
      AuthPage.route: (context) => const AuthPage(
            key: ValueKey("value"),
          ),
      LoginPage.route: ((context) => const LoginPage()),
      DashBoardPage.route: ((context) => const DashBoardPage()),
      LessonDetailPage.route: ((context) {
        final id =
            (ModalRoute.of(context)?.settings.arguments as Map)["lessonId"];
        return LessonDetailPage(lessonId: id);
      }),
      LessonPage.route: (context) => const LessonPage()
    };
