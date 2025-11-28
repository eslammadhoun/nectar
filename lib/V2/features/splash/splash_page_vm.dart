import 'package:flutter/material.dart';
import 'package:nectar/V2/Data/services/auth_log_state.dart';

class SplashPageVm extends ChangeNotifier {
  // final _auth = FirebaseAuth.instance;
  
  String? _nextRoute;
  String? get nextRoute => _nextRoute;
  
  // Future<void> chechNextRoute() async {
  //   User? user = _auth.currentUser;
  //   _nextRoute = user != null ? '/home_page' : '/onbording_page';
  // }

  Future<void> checkNextRoute() async {
    await Future.delayed(Duration(seconds: 2));
    bool isUserLogin = await AuthLogState.getLoginState();
    _nextRoute = isUserLogin ? '/home_page' : '/onbording_page';
  }
}
