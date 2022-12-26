import 'package:dio/dio.dart';
import 'package:lms_app/api/app_dio.dart';
import 'package:lms_app/repository/auth_repository.dart';

class AuthInterceptor extends Interceptor {
  final AppDio dioClient;

  AuthInterceptor({required this.dioClient});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print("cookie");
    print(AuthRepository.cookieId);
    options.headers.addAll({"cookie": AuthRepository.cookieId});
    super.onRequest(options, handler);
  }
}
