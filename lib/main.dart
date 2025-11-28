import 'package:firebase_core/firebase_core.dart';
import 'package:nectar/V2/Core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:nectar/V2/Core/helpers/app_routes.dart';
import 'package:nectar/V2/Core/helpers/app_navigator.dart';
import 'package:nectar/V2/Core/helpers/providers_setup.dart';
import 'package:nectar/V2/Core/utils/network_connection/network_connection_vm.dart';
import 'package:nectar/V2/Core/utils/network_connection/overlay_service.dart';
import 'package:nectar/V2/Data/services/auth_log_state.dart';
import 'package:nectar/V2/features/splash/splash_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AuthLogState.sharedPrefsInit();
  runApp(MultiProvider(providers: providers, child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkViewModel>(
      builder: (context, net, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!net.isConnected) {
            OverlayService.show();
          } else {
            OverlayService.hide();
          }
        });
        return MaterialApp(
          navigatorKey: navigatorKey,
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          home: SplashPage(),
          routes: routes,
        );
      },
    );
  }
}