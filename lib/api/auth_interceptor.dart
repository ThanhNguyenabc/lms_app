import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:lms_app/api/app_dio.dart';
import 'package:lms_app/service_locator.dart';
import 'package:lms_app/utils/string_util.dart';

class AuthInterceptor extends Interceptor {
  final AppDio dioClient;

  AuthInterceptor({required this.dioClient});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll({"cookie": getIt.get<Box>().get(cookieKey)});
    super.onRequest(options, handler);
  }
}
