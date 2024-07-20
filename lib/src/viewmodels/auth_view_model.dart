//create authviewmodel provider class

import 'package:flutter/material.dart';
import 'package:merem_chat_app/core/helpers/navigator_service.dart';
import 'package:merem_chat_app/src/view/auth/login_page.dart';
import 'package:merem_chat_app/src/view/auth/register_page.dart';
import 'package:merem_chat_app/src/view/chat/home_page.dart';

class AuthViewModel extends ChangeNotifier {
  final NavigationService _navigationService;

  AuthViewModel(this._navigationService);
  navigateToHome() {
    _navigationService.navigateAndRemove(const HomePage());
  }

  navigateToRegister() {
    _navigationService.navigate(const RegisterPage());
  }

  navigateToLogin() {
    _navigationService.navigate(const LoginPage());
  }
}
