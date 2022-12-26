import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lms_app/app_routes.dart';
import 'package:lms_app/screens/auth/login_page.dart';
import 'package:lms_app/service_locator.dart';

dynamic parseSafe(String? source) {
  if (source == null) return {};
  try {
    return jsonDecode(source);
  } catch (e) {
    return {};
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependency();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getIt.allReady(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.deepPurple,
              ),
              routes: appRoutes(),
              initialRoute: LoginPage.route,
            );
          } else {
            return Container(
              color: Colors.white,
              child: const Center(child: CircularProgressIndicator()),
            );
          }
        }));
  }
}
