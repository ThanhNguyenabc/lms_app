import 'dart:convert';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
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
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
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
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
        ),
        routes: AppRoutes,
        initialRoute: AuthPage.route,
      ),
    );
  }
}
