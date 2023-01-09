import 'package:flutter/material.dart';
import 'package:lms_app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';

import '../auth/login_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthViewModel>().logout().then((value) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginPage.route, (route) => false);
                });
              },
              child: const Text("Log out"),
            ),
          )
        ],
      ),
    );
  }
}
