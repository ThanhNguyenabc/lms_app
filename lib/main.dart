import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lms_app/app_routes.dart';
import 'package:lms_app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:lms_app/features/lesson/viewmodel/lesson_viewmodel.dart';
import 'package:lms_app/service_locator.dart';
import 'package:provider/provider.dart';

import 'features/auth/auth_page.dart';

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
  initDependency();
  await getIt.allReady();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<AuthViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<LessonViewModel>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
        ),
        routes: appRoutes(),
        initialRoute: AuthPage.route,
      ),
    );
  }
}
