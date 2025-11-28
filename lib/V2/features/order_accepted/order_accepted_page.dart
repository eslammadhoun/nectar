import 'package:flutter/material.dart';
import 'package:nectar/V2/features/home/home_page.dart';
import 'package:nectar/V2/Core/theme/app_theme.dart';

class OrderAcceptedPage extends StatelessWidget {
  const OrderAcceptedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      body: Stack(
        children: [
          Image.asset(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            "assets/images/phonepageBc.png",
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                SizedBox(height: 150),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Center(
                    child: Image.asset("assets/images/acceptedImg.png"),
                  ),
                ),
                SizedBox(height: 60),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    "Your Order has been accepted",
                    style: TextStyle(
                      color: AppTheme.textColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Your items has been placcd and is on it’s way to being processed",
                      style: TextStyle(
                        color: AppTheme.secondaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 130),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 67,
                    decoration: BoxDecoration(
                      color: AppTheme.mainColor,
                      borderRadius: BorderRadius.circular(19),
                    ),
                    child: Center(
                      child: Text(
                        "Track Order",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:
                      () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage()),
                      ),
                  child: SizedBox(
                    height: 67,
                    child: Center(
                      child: Text(
                        "Back to home",
                        style: TextStyle(
                          color: AppTheme.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gilroy',
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
