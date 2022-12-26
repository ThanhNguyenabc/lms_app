import 'package:flutter/material.dart';
import 'package:lms_app/base/view/base_view.dart';
import 'package:lms_app/service_locator.dart';

import 'viewmodel/auth_viewmodel.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
        vmBuilder: (context) => getIt<AuthViewModel>(),
        builder: (context) {
          return Container();
        });
  }
}
