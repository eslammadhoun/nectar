import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nectar/V2/features/home/home_page_vm.dart';
import 'package:nectar/V2/features/login/login_page_vm.dart';
import 'package:provider/provider.dart';
import 'package:nectar/V2/Core/theme/app_theme.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginPageVm>(
      builder: (context, vm, child) {
        return Scaffold(
          backgroundColor: AppTheme.lightBackground,
          body: Stack(
            children: <Widget>[
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
                    Center(
                      child: Padding(
                        padding: EdgeInsetsGeometry.only(top: 100, bottom: 100),
                        child: SvgPicture.asset(
                          "assets/icons/appiconfilled.svg",
                        ),
                      ),
                    ),
                    Text(
                      "Loging",
                      style: TextStyle(
                        color: AppTheme.textColor,
                        fontSize: 26,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Enter your emails and password",
                      style: TextStyle(
                        color: Color(0xFF7c7c7c),
                        fontSize: 16,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE2E2E2),
                            width: 2.0,
                          ),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Color(0xFF7c7c7c),
                          fontSize: 16,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w500,
                        ),
                        label: Text("Email", style: TextStyle()),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE2E2E2),
                            width: 2.0,
                          ),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Color(0xFF7c7c7c),
                          fontSize: 16,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w500,
                        ),
                        label: Text("Password", style: TextStyle()),
                        suffixIcon: IconButton(
                          icon: Icon(
                            (vm.obscureText
                                ? Icons.remove_red_eye_outlined
                                : Icons.visibility_off_outlined),
                          ),
                          onPressed: () => vm.toggleObscureText(),
                        ),
                      ),
                      obscureText: vm.obscureText,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forget Password? ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textColor,
                            fontFamily: 'Gilroy',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () async {
                        String? message = await vm.login(
                          _emailController.text,
                          _passwordController.text,
                        );
                        if (context.mounted) {
                          if (message == 'Login Succs') {
                            Navigator.of(
                              context,
                            ).pushReplacementNamed('/home_page');
                            Provider.of<HomePageVm>(context, listen: false).selectedIndex = 0;
                          }
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(message)));
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        decoration: BoxDecoration(
                          color: AppTheme.mainColor,
                          borderRadius: BorderRadius.circular(19),
                        ),
                        child: Center(
                          child:
                              (vm.isloading)
                                  ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : Text(
                                    "Log In",
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
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don’t have an account? ",
                          style: TextStyle(
                            color: AppTheme.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/register_page',
                              ),
                          child: Text(
                            "Signup",
                            style: TextStyle(
                              color: AppTheme.mainColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
