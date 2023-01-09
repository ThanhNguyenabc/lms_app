import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lms_app/_widgets/loading.dart';
import 'package:lms_app/models/auth_status.dart';
import 'package:lms_app/service_locator.dart';
import 'package:provider/provider.dart';
import '../dashboard/dashboard_page.dart';
import 'viewmodel/auth_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const route = "/login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userController = TextEditingController();

  final TextEditingController pwdController = TextEditingController();
  final AuthViewModel authViewModel = getIt.get<AuthViewModel>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      authViewModel.addListener(authListener);
    });
  }

  void authListener() {
    print("auth viewmodel call");
    if (authViewModel.isLoading) {
      showLoginDialog(context);
    } else if (!authViewModel.isLoading) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    if (authViewModel.errorMessage?.isNotEmpty == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("OOPS! Your user name or password is incorrect")));
      return;
    }

    if (authViewModel.authStatus == AuthStatus.authenticated) {
      Navigator.popAndPushNamed(context, DashBoardPage.route);
    }
  }

  @override
  void dispose() {
    authViewModel.removeListener(authListener);
    userController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
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
                    onPressed: () => handleLogin(context),
                    child: const Text("Login")),
              )
            ],
          )),
    );
  }

  showLoginDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: ((context) {
          return const SimpleDialog(
            children: [
              Loading(),
              SizedBox(
                height: 8,
              ),
              Center(
                child: Text("Loading"),
              )
            ],
          );
        }));
  }

  handleLogin(BuildContext context) {
    final String username = userController.text.trim();
    final String pwd = pwdController.text.trim();
    if (username.isEmpty || pwd.isEmpty) return;
    context.read<AuthViewModel>().login(username, pwd);
  }
}
