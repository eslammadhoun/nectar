import 'package:flutter/material.dart';
import 'package:nectar/V2/Data/services/auth_service.dart';

class SignUpVm extends ChangeNotifier {
  bool obscureText = true;
  bool isloading = false;

  Future<String?> signUp(String userName, String email, String password) async {
    isloading = true;
    notifyListeners();
    final message = await AuthService.signUp(userName, email, password);
    isloading = false;
    notifyListeners();
    return message!;
  }

  void toggleObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }
}
