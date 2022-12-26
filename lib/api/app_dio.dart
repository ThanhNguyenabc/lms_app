import 'package:dio/dio.dart';
import 'package:lms_app/api/auth_interceptor.dart';
import 'package:lms_app/main.dart';
import 'package:lms_app/models/result.dart';

const baseURL = "https://dev.ila.edu.vn/lms/lab";

class HttpMethod {
  static const String get = "GET";
  static const String post = "POST";
  static const String put = "PUT";
  static const String head = "HEAD";
  static const String delete = "DELETE";
  static const String patch = "PATCH";
}

class AppDio {
  late Dio _dioClient;

  AppDio._() {
    final options = BaseOptions(
        baseUrl: '$baseURL/api.php',
        connectTimeout: 5000,
        headers: {'Accept': 'application/json'},
        receiveTimeout: 5000);
    _dioClient = Dio(options);
    _dioClient.interceptors
        .addAll([AuthInterceptor(dioClient: this), LogInterceptor()]);
  }

  factory AppDio.instance() => AppDio._();

  Future<Result<T>> get<T>({
    String? path,
    T Function(dynamic)? transform,
    Map<String, dynamic>? params,
  }) =>
      _fetchData(HttpMethod.get,
          path: path, params: params, transform: transform);

  Future<Result<T>> post<T>({
    String? path,
    T Function(dynamic)? transform,
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
  }) =>
      _fetchData(HttpMethod.post,
          path: path, params: params, requestData: data, transform: transform);

  Future<Result<T>> _fetchData<T>(
    String method, {
    T Function(dynamic)? transform,
    String? path,
    Map<String, dynamic>? params,
    Map<String, dynamic>? requestData,
  }) async {
    try {
      final response = await _dioClient.request(
        path ?? '',
        options: Options(method: method),
        queryParameters: params,
        data: requestData,
      );

      final statusCode = response.statusCode;

      if (statusCode != 200) return Result.error("OOps! Something is wrong");

      var data = response.data;

      if (data != null && data is String) {
        data = data.trim();
        data = parseSafe(data);
      }

      return Result.success(transform?.call(data) ?? data);
    } catch (e) {
      print("---------error-------");
      print(e);
      return Result.error("OOps! Something is wrong");
    }
  }
}
