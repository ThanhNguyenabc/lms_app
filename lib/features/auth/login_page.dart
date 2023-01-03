import 'package:flutter/material.dart';
import 'package:lms_app/base/view/base_view.dart';
import 'package:lms_app/models/auth_status.dart';
import 'package:lms_app/service_locator.dart';
import 'package:provider/provider.dart';
import '../dashboard/dashboard_page.dart';
import 'viewmodel/auth_viewmodel.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  static const route = "/login";
  final TextEditingController userController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView(
        vmBuilder: (context) => getIt<AuthViewModel>(),
        builder: (BuildContext context) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Consumer(builder: (c, AuthViewModel viewmodel, child) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Image.asset(
                      "asset/images/logo.png",
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    TextFormField(
                      controller: userController,
                      decoration: const InputDecoration(hintText: "user name"),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    TextFormField(
                      controller: pwdController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "password",
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => handleLogin(c),
                          child: const Text("Login")),
                    )
                  ],
                );
              }),
            ),
          );
        });
  }

  handleLogin(BuildContext context) {
    final String username = userController.text.trim();
    final String pwd = pwdController.text.trim();
    context.read<AuthViewModel>().login(username, pwd).then((value) => {
          if (value == AuthStatus.authenticated)
            Navigator.popAndPushNamed(context, DashBoardPage.route)
          else
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("OOPS! Your user name or password is incorrect")))
        });
  }
}
