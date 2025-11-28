import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nectar/V2/Core/theme/app_theme.dart';

// ignore: must_be_immutable
class CustomBottomNavbar extends StatelessWidget {
  final int selectedIndex;
  Function(int) onTap;

  CustomBottomNavbar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFE6EBF3).withOpacity(0.50),
            blurRadius: 37,
            offset: Offset(0, -12),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem("assets/icons/shopIcon.svg", 0),
          _buildNavItem("assets/icons/exploreIcon.svg", 1),
          _buildNavItem("assets/icons/cartIcon.svg", 2),
          _buildNavItem("assets/icons/favouriteIcon.svg", 3),
          _buildNavItem("assets/icons/accountIcon.svg", 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(String asset, int index) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: SvgPicture.asset(
        asset,
        color: selectedIndex == index ? AppTheme.mainColor : AppTheme.textColor,
      ),
    );
  }
}
