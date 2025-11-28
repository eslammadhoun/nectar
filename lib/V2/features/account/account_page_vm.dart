import 'package:flutter/cupertino.dart';

import '../../Data/services/auth_service.dart';

class AccountPageVm extends ChangeNotifier {
  AuthService authService;
  AccountPageVm({required this.authService});

  String userName = 'UserName';
  String userEmail = 'email@gmail.com';
  bool editMode = false;

  Future<void> getUserName() async {
    userName = await authService.getUserName() ?? 'UserName';
    notifyListeners();
  }

  Future<void> getUserEmail() async {
    userEmail = await authService.getUserEmail() ?? 'UserEmail';
    notifyListeners();
  }

  void toggleEditMode() {
    editMode = !editMode;
    notifyListeners();
  }

  Future<void> changeUserName(String newUserName) async {
    await authService.changeUserName(newUserName);
    userName = newUserName;
    notifyListeners();
  }

  Future<void> logOut() async {
    await authService.logOut();
    userName = 'UserName';
    userEmail = 'UserEmail';
    notifyListeners();
  }
}