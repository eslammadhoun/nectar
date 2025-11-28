import 'package:flutter/material.dart';
import 'package:nectar/V2/features/login/login_page.dart';
import 'package:nectar/V2/features/signup/sign_up_page.dart';
import 'package:nectar/V2/features/home/home_page.dart';
import 'package:nectar/V2/features/account/account_page.dart';
import 'package:nectar/V2/features/location/location_page.dart';
import 'package:nectar/V2/features/onbording/onbording_page.dart';

Map<String, Widget Function (BuildContext)> routes = {
  '/home_page' : (context) => HomePage(),
          '/onbording_page' : (context) => OnbordingPage(),
         '/login_page' : (context) => LoginPage(),
         '/register_page' : (context) => RegisterPage(),
         '/location_page' : (context) => LocationPage(),
         '/account_page' : (context) => AccountPage(),
};