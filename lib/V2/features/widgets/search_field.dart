import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nectar/V2/Core/theme/app_theme.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          fillColor: Color(0xFFF2F3F2),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFF2F3F2)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFF2F3F2)),
            borderRadius: BorderRadius.circular(15),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 15, right: 10),
            child: SvgPicture.asset("assets/icons/seacrhIcon.svg"),
          ),
          prefixIconConstraints: BoxConstraints(maxWidth: 50, maxHeight: 50),
          hint: Text(
            "Search Store",
            style: TextStyle(
              color: AppTheme.secondaryText,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Gilroy',
            ),
          ),
        ),
      ),
    );
  }
}
