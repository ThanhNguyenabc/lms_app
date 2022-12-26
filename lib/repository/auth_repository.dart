import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms_app/api/app_dio.dart';
import 'package:lms_app/models/result.dart';
import 'package:lms_app/models/user.dart';
import 'package:lms_app/service_locator.dart';

String cookieKey = "cookie";

class AuthRepository {
  static String cookieId = "";

  Future<Result<User>> login(String username, String password) async {
    final res = await getIt<AppDio>().post<User>(
        params: {"f": "Core_Login"},
        data: {'user_id': username, 'password': password},
        transform: ((data) => User.fromMap(data)));

    return res;
  }

  Future<Result<void>> setTimeZone() async {
    final res = await getIt<AppDio>().post(
        params: {"f": "Core_SetTimezone"}, data: {"timezone": "Asia/Saigon"});
    return res;
  }

  Future<Result<String>> getCookieId() async {
    try {
      final res = await Dio().get(baseURL);
      final networkCookie =
          ((res.headers['set-cookie'])?[0] as String).split(';')[0];
      return Result.success(networkCookie);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<String?>> getCacheCookie() async {
    try {
      final Box appBox = await getIt<HiveInterface>().openBox("app");

      final cookie = appBox.get(cookieKey);
      return Result.success(cookie);
    } catch (e) {
      print(e);
      return Result.error(e.toString());
    }
  }

  Future<Result<bool>> saveCookieToLocal(String cookie) async {
    try {
      print("cookie====");
      print(cookie);
      final appBox = Hive.box('app');
      print("app box");
      print(appBox);
      await appBox.put(cookieKey, cookie);
      return Result.success(true);
    } catch (e) {
      print("save cookie local");
      print(e);
      return Result.success(false);
    }
  }

  Future<bool> getToken() async {
    var cookie = (await getCacheCookie()).data;
    if (cookie == null || cookie.isEmpty) {
      final newCookie = (await getCookieId()).data;
      print("new cookie");
      print(newCookie);
      if (newCookie == null) return false;
      cookie = newCookie;
      AuthRepository.cookieId = cookie;
      await setTimeZone();
      await saveCookieToLocal(cookie);
    }
    AuthRepository.cookieId = cookie;

    return true;
  }
}
