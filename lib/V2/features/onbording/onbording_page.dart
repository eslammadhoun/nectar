import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nectar/V2/Core/theme/app_theme.dart';
class OnbordingPage extends StatefulWidget {
  const OnbordingPage({super.key});

  @override
  State<OnbordingPage> createState() => _OnbordingPageState();
}

class _OnbordingPageState extends State<OnbordingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: SizedBox.expand(
              child: Image.asset(
                "assets/images/onbordingBc.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 90,
            child: Column(
              children: <Widget>[
                SvgPicture.asset("assets/icons/appicon.svg"),
                SizedBox(height: 35),
                Text(
                  textAlign: TextAlign.center,
                  "Welcome\nto our store",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.bold,
                    height: 0,
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  "Ger your groceries in as fast as one hour",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.lightBackground.withOpacity(0.70),
                  ),
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap:
                      () => Navigator.pushReplacementNamed(
                        context,
                        '/login_page',
                      ),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    padding: EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      color: AppTheme.mainColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          fontFamily: "Gilroy",
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
