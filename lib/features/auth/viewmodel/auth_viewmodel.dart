import 'package:lms_app/base/viewmodel/base_viewmodel.dart';
import 'package:lms_app/models/auth_status.dart';
import 'package:lms_app/models/result.dart';
import 'package:lms_app/models/user.dart';
import 'package:lms_app/repository/auth_repository.dart';

class AuthViewModel extends BaseViewModel {
  final AuthRepository repository;
  AuthViewModel({required this.repository});

  AuthStatus authStatus = AuthStatus.unauthenticated;
  User? currentUser;
  String? errorMessage;

  @override
  Future<void> init() async {
    checkAutheticaton();
  }

  void checkAutheticaton() async {
    final cacheUser = await repository.isAuthenticated();
    if (cacheUser != null) {
      authStatus = AuthStatus.authenticated;
      currentUser = cacheUser;
    }
  }

  void login(String username, String password) async {
    errorMessage = null;
    setLoading(true);
    final Result<User> res = await repository.login(username, password);
    if (res.status == Status.success) {
      currentUser = res.data;
      authStatus = AuthStatus.authenticated;
    } else if (res.status == Status.error) {
      errorMessage = res.message;
    }
    setLoading(false);
  }

  Future<bool> logout() async {
    setLoading(true);
    await repository.logout();
    authStatus = AuthStatus.unauthenticated;
    currentUser = null;
    setLoading(false);
    return true;
  }
}
