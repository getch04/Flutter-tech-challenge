// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:merem_chat_app/core/helpers/shared_preference.dart' as _i3;
import 'package:merem_chat_app/core/state/app_state.dart' as _i4;
import 'package:merem_chat_app/di.dart' as _i9;
import 'package:merem_chat_app/src/services/auth_services.dart' as _i7;
import 'package:merem_chat_app/src/viewmodels/auth_view_model.dart' as _i8;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.SharedPreferencesService>(
        () => _i3.SharedPreferencesService());
    gh.lazySingleton<_i4.AppState>(() => registerModule.appState);
    gh.lazySingleton<_i5.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i6.FirebaseFirestore>(() => registerModule.firestore);
    gh.lazySingleton<_i7.AuthService>(() => _i7.AuthService(
          gh<_i5.FirebaseAuth>(),
          gh<_i6.FirebaseFirestore>(),
        ));
    gh.singleton<_i8.AuthViewModel>(() => _i8.AuthViewModel(
          gh<_i7.AuthService>(),
          gh<_i3.SharedPreferencesService>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i9.RegisterModule {}
