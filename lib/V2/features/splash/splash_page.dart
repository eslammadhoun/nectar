import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nectar/V2/Core/theme/app_theme.dart';
import 'package:nectar/V2/features/splash/splash_page_vm.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) async {
      final splashVm = Provider.of<SplashPageVm>(context, listen: false);
      await splashVm.checkNextRoute();
      if (context.mounted) {
        if (splashVm.nextRoute != null) {
          Navigator.of(context).pushReplacementNamed(splashVm.nextRoute!);
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.mainColor,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/appicon.svg"),
            SizedBox(width: 18),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "nectar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),

                Text(
                  "online groceriet",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
