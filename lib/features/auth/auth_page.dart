import 'package:flutter/material.dart';
import 'package:lms_app/features/auth/login_page.dart';
import 'package:lms_app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:lms_app/features/dashboard/dashboard_page.dart';
import 'package:lms_app/models/auth_status.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  static const route = "/auth";
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Future<void> navigatePage(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;

    if (context.read<AuthViewModel>().authStatus == AuthStatus.authenticated) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(DashBoardPage.route, (route) => false);
    } else {
      Navigator.pushNamed(context, LoginPage.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    navigatePage(context);
    return Container(
      color: Colors.white,
      child: const Center(
          child: CircularProgressIndicator(
        color: Colors.white,
      )),
    );
  }
}
