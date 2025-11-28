import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nectar/V2/features/signup/sign_up_vm.dart';
import 'package:provider/provider.dart';
import 'package:nectar/V2/Core/theme/app_theme.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpVm>(
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
                      "Sign Up",
                      style: TextStyle(
                        color: AppTheme.textColor,
                        fontSize: 26,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Enter your credentials to continue",
                      style: TextStyle(
                        color: Color(0xFF7c7c7c),
                        fontSize: 16,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      controller: _userNameController,
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
                        label: Text("Username", style: TextStyle()),
                      ),
                    ),
                    SizedBox(height: 30),
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
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "By continuing you agree to our ",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.textColor,
                                fontFamily: 'Gilroy',
                              ),
                            ),
                            Text(
                              "Terms of Service",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.mainColor,
                                fontFamily: 'Gilroy',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "and ",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.textColor,
                                fontFamily: 'Gilroy',
                              ),
                            ),
                            Text(
                              "Privacy Policy.",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.mainColor,
                                fontFamily: 'Gilroy',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () async {
                        final message = await vm.signUp(
                          _userNameController.text,
                          _emailController.text,
                          _passwordController.text,
                        );
                        if (context.mounted) {
                          if (message == 'New Account Created') {
                            Navigator.of(
                              context,
                            ).pushReplacementNamed('/location_page');
                          }
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(message!)));
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
                                    "Sign Up",
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
                          "Already have an account? ",
                          style: TextStyle(
                            color: AppTheme.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap:
                              () => Navigator.pushNamed(context, '/login_page'),
                          child: Text(
                            "LogIn",
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
