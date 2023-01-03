import 'package:flutter/material.dart';
import 'package:lms_app/screens/auth/auth_page.dart';
import 'package:lms_app/screens/auth/login_page.dart';

Map<String, WidgetBuilder> getAuthRoutes() => {
      AuthPage.route: (context) => const AuthPage(),
      LoginPage.route: (context) => LoginPage()
    };
