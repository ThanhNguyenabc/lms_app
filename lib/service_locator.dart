import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms_app/api/app_dio.dart';
import 'package:lms_app/repository/auth_repository.dart';
import 'package:lms_app/repository/lesson_repository.dart';
import 'package:lms_app/screens/auth/viewmodel/auth_viewmodel.dart';
import 'package:lms_app/screens/lesson/viewmodel/lesson_viewmodel.dart';

GetIt getIt = GetIt.instance;

Future<void> initDependency() async {
  // global
  getIt
    ..registerSingleton(AppDio.instance())
    ..registerSingletonAsync<HiveInterface>(() async {
      await Hive.initFlutter();
      return Hive;
    });

  //register repositories
  getIt
    ..registerSingletonAsync(() async => AuthRepository())
    ..registerFactory(() => LessonRepository());

//register viewmodel
  getIt
    ..registerSingletonAsync(
        () async => AuthViewModel(repository: getIt<AuthRepository>()),
        dependsOn: [AuthRepository, HiveInterface])
    ..registerFactory(
        () => LessonViewModel(repository: getIt<LessonRepository>()));
}
