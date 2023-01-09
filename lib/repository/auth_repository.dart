import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms_app/api/app_dio.dart';
import 'package:lms_app/models/result.dart';
import 'package:lms_app/models/user.dart';
import 'package:lms_app/service_locator.dart';

import '../utils/string_util.dart';

class AuthRepository {
  static String cookieId = "";
  Box<dynamic> appBox;

  AuthRepository({required this.appBox});

  Future<Result<User>> login(String username, String password) async {
    await getSession();
    final res = await getIt<AppDio>().post<User>(
        params: {"f": "Core_Login"},
        data: {'user_id': username, 'password': password},
        transform: ((data) => User.fromMap(data)));
    if (res.data != null) {
      await appBox.putAll({isLoggedKey: true, userKey: res.data?.toMap()});
    }
    return res;
  }

  Future<bool> logout() async {
    await getIt<AppDio>().post(params: {"f": "Core_Logout"});
    await appBox.clear();
    return true;
  }

  Future<Result<void>> setTimeZone() async {
    final res = await getIt<AppDio>().post(
        params: {"f": "Core_SetTimezone"}, data: {"timezone": "Asia/Saigon"});
    return res;
  }

  Future<Result<String>> getNewCookie() async {
    try {
      final res = await Dio().get(baseURL);
      final networkCookie =
          ((res.headers['set-cookie'])?[0] as String).split(';')[0];
      return Result.success(networkCookie);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Result<String?> getCacheCookie() {
    try {
      final cookie = appBox.get(cookieKey);
      return Result.success(cookie);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<bool>> saveCookieToLocal(String cookie) async {
    try {
      await appBox.put(cookieKey, cookie);
      return Result.success(true);
    } catch (e) {
      return Result.success(false);
    }
  }

  Future<bool> getSession() async {
    var cookie = (getCacheCookie()).data;
    if (cookie == null || cookie.isEmpty) {
      final newCookie = (await getNewCookie()).data;
      if (newCookie == null) return false;
      cookie = newCookie;
      await saveCookieToLocal(cookie);
      await setTimeZone();
    }
    return true;
  }

  Future<User?> isAuthenticated() async {
    final isLogged = appBox.get(isLoggedKey, defaultValue: false);
    final userInfo = appBox.get(userKey, defaultValue: {});
    await getSession();

    if (isLogged && userInfo.isNotEmpty) {
      return User.fromMap(Map<String, dynamic>.from(userInfo));
    }
    return null;
  }
}
