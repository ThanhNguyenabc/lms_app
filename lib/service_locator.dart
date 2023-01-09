import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms_app/api/app_dio.dart';
import 'package:lms_app/features/lesson_detail/lesson_detail_viewmodel.dart';
import 'package:lms_app/features/next_lesson/next_lesson_viewmodel.dart';
import 'package:lms_app/features/overall_progress/overall_progress_viewmodel.dart';
import 'package:lms_app/repository/auth_repository.dart';
import 'package:lms_app/repository/lesson_repository.dart';
import 'package:lms_app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:lms_app/features/lesson/viewmodel/lesson_viewmodel.dart';

GetIt getIt = GetIt.instance;

Future<void> initDependency() async {
  // global
  getIt
    ..registerSingleton(AppDio.instance())
    ..registerSingletonAsync<HiveInterface>(() async {
      await Hive.initFlutter();
      return Hive;
    });

  getIt.registerSingletonAsync<Box<dynamic>>(
    () async {
      final box = await getIt<HiveInterface>().openBox("app");
      return box;
    },
    dependsOn: [HiveInterface],
  );

  //register repositories
  getIt
    ..registerSingletonAsync<AuthRepository>(
        () async => AuthRepository(appBox: getIt.get<Box>()),
        dependsOn: [Box<dynamic>])
    ..registerSingleton<LessonRepository>(LessonRepository());

//register viewmodel
  getIt
    ..registerSingletonAsync<AuthViewModel>(
        () async => AuthViewModel(repository: getIt<AuthRepository>()),
        dependsOn: [AuthRepository])
    ..registerFactory<LessonViewModel>(
        () => LessonViewModel(repository: getIt<LessonRepository>()))
    ..registerFactory<LessonDetailViewModel>(
        () => LessonDetailViewModel(repository: getIt<LessonRepository>()))
    ..registerFactory<OverallProgressViewModel>(
        () => OverallProgressViewModel(repository: getIt<LessonRepository>()))
    ..registerFactory<NextLessonViewModel>(
        () => NextLessonViewModel(repository: getIt<LessonRepository>()));
}
