import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nectar/V2/Data/services/auth_log_state.dart';
import 'package:nectar/V2/Core/theme/app_theme.dart';
import 'package:nectar/V2/features/account/account_page_vm.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final vm = Provider.of<AccountPageVm>(context, listen: false);
      await Future.wait([vm.getUserName(), vm.getUserEmail()]);
      setState(() {
        _nameController.text = vm.userName;
      });
    });
  }

  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountPageVm>(
      builder: (context, vm, child) {
        return Scaffold(
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            children: [
              const SizedBox(height: 70),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.amber,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        "assets/images/profileImg.jpeg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child:
                                  vm.editMode
                                      ? TextFormField(
                                        autofocus: true,
                                        controller: _nameController,
                                        decoration: InputDecoration(),
                                      )
                                      : Text(
                                        vm.userName,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: AppTheme.textColor,
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                            ),
                            SizedBox(width: 10),
                            IconButton(
                              onPressed: () {
                                if (vm.editMode) {
                                  vm.changeUserName(_nameController.text);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('User Name Updated'),
                                    ),
                                  );
                                }
                                vm.toggleEditMode();
                              },
                              icon:
                                  vm.editMode
                                      ? Icon(Icons.done, size: 30)
                                      : Icon(Icons.edit, size: 20),
                              color: AppTheme.mainColor,
                            ),
                          ],
                        ),
                        Text(
                          vm.userEmail,
                          style: const TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppTheme.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Container(height: 1, color: Color(0xffE2E2E2)),
              profileItem("Orders", "assets/icons/ordersIcon.svg", () {}),
              profileItem("My Details", "assets/icons/detailsIcon.svg", () {}),
              profileItem(
                "Delivery Address",
                "assets/icons/addressIcon.svg",
                () => Navigator.of(context).pushNamed('/location_page'),
              ),
              profileItem(
                "Payment Methods",
                "assets/icons/paymentIcon.svg",
                () {},
              ),
              profileItem("Promo Code", "assets/icons/promoIcon.svg", () {}),
              profileItem("Notifications ", "assets/icons/notIcon.svg", () {}),
              profileItem("Help", "assets/icons/helpIcon.svg", () {}),
              profileItem("About ", "assets/icons/aboutIcon.svg", () {}),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () async {
                  vm.logOut();
                  if (context.mounted) {
                    Navigator.of(context).pushNamed('/login_page');
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  height: 67,
                  decoration: BoxDecoration(
                    color: Color(0xffF2F3F2),
                    borderRadius: BorderRadius.circular(19),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.logout, color: AppTheme.mainColor),
                        Text(
                          "Log Out",
                          style: TextStyle(
                            color: AppTheme.mainColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                          ),
                        ),
                        Container(width: 25),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget profileItem(
    String itemName,
    String iconTitle,
    void Function()? onPressed,
  ) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(iconTitle),
                  Container(width: 20),
                  Text(
                    itemName,
                    style: TextStyle(
                      color: AppTheme.textColor,
                      fontSize: 18,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: onPressed,
              ),
            ],
          ),
        ),
        Container(height: 1, color: Color(0xffE2E2E2)),
      ],
    );
  }
}
