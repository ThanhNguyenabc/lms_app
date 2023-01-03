import 'package:flutter/material.dart';

import 'auth_page.dart';
import 'login_page.dart';

Map<String, WidgetBuilder> getAuthRoutes() => {
      AuthPage.route: (context) => const AuthPage(),
      LoginPage.route: (context) => LoginPage()
    };
