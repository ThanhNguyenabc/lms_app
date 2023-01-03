import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lms_app/app_routes.dart';
import 'package:lms_app/features/auth/auth_page.dart';
import 'package:lms_app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:lms_app/service_locator.dart';
import 'package:provider/provider.dart';

dynamic parseSafe(String? source) {
  if (source == null) return {};
  try {
    return jsonDecode(source);
  } catch (e) {
    return {};
  }
}

Box? appBox;
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
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => getIt<AuthViewModel>()),
              ],
              child: MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                routes: appRoutes(),
                initialRoute: AuthPage.route,
              ),
            );
          }
          return Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()),
          );
        }));
  }
}
