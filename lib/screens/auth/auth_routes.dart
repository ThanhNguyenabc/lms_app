import 'package:flutter/material.dart';
import 'package:lms_app/screens/auth/login_page.dart';

Map<String, WidgetBuilder> getAuthRoutes() =>
    {LoginPage.route: (context) => LoginPage()};
