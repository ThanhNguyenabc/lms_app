import 'package:lms_app/base/viewmodel/base_viewmodel.dart';
import 'package:lms_app/models/auth_status.dart';
import 'package:lms_app/models/result.dart';
import 'package:lms_app/models/user.dart';
import 'package:lms_app/repository/auth_repository.dart';

class AuthViewModel extends BaseViewModel {
  final AuthRepository repository;
  AuthViewModel({required this.repository});

  AuthStatus authStatus = AuthStatus.unauthenticated;

  @override
  Future<void> init() async {
    checkAutheticaton();
  }

  void checkAutheticaton() async {
    final isAuthenticated = await repository.isAuthenticated();
    if (isAuthenticated) {
      authStatus = AuthStatus.authenticated;
    }
  }

  Future<AuthStatus?> login(String username, String password) async {
    if (password.isEmpty || username.isEmpty) return null;
    final Result<User> res = await repository.login(username, password);
    authStatus = res.data != null
        ? AuthStatus.authenticated
        : AuthStatus.unauthenticated;

    return authStatus;
  }
}
