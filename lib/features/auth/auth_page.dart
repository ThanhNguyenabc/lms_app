import 'package:flutter/material.dart';
import 'package:lms_app/models/auth_status.dart';
import 'package:provider/provider.dart';

import '../dashboard/dashboard_page.dart';
import 'login_page.dart';
import 'viewmodel/auth_viewmodel.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  static const route = "/auth_page";

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, AuthViewModel value, child) {
      if (value.isLoading) {
        return const CircularProgressIndicator();
      }
      if (value.authStatus == AuthStatus.authenticated) {
        return const DashBoardPage();
      }
      return LoginPage();
    }));
  }
}
