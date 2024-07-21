//create authviewmodel provider class

import 'package:injectable/injectable.dart';
import 'package:merem_chat_app/core/helpers/shared_preference.dart';
import 'package:merem_chat_app/core/state/app_state.dart';
import 'package:merem_chat_app/src/services/auth_services.dart';

@singleton
class AuthViewModel extends AppState {
  final SharedPreferencesService _prefService;
  final AuthService _authService;

  AuthViewModel(this._authService, this._prefService);

  Future<bool> registerWithEmailPassword({
    required String email,
    required String password,
    required String username,
  }) async {
    final result = _authService.registerWithEmailPassword(
      email: email,
      password: password,
      username: username,
    );
    return await result.match(
      (error) {
        print('Error: $error');
        return false;
      },
      (final user) {
        _prefService.saveString(
          'user_id',
          user.uid,
        );
        return true;
      },
    ).run();
  }
}
