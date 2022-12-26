import 'package:flutter/material.dart';
import 'package:lms_app/screens/auth/auth_routes.dart';
import 'package:lms_app/screens/dashboard/dashboard_page.dart';

Map<String, WidgetBuilder> appRoutes() => {
      DashBoardPage.route: ((context) => const DashBoardPage()),
      ...getAuthRoutes()
    };
