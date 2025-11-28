import 'package:flutter/material.dart';
import 'package:nectar/V2/Data/services/auth_service.dart';

class LoginPageVm extends ChangeNotifier {
  bool obscureText = true;
  bool isloading = false;

  Future<String> login(String email, String password) async {
    isloading = true;
    notifyListeners();
    String? message = await AuthService.login(email, password);
    isloading = false;
    notifyListeners();
    return message!;
  }

  void toggleObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }
}
