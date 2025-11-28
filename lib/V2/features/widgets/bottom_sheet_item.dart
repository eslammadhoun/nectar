import 'package:flutter/material.dart';
import 'package:nectar/V2/Core/theme/app_theme.dart';

class BottomSheetItem extends StatelessWidget {
  final String name;
  final operation;
  const BottomSheetItem({super.key, required this.name, required this.operation});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(
            color: AppTheme.secondaryText,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Gilroy',
          ),
        ),
        Row(
          children: [
            Text(
              operation,
              style: TextStyle(
                color: AppTheme.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Gilroy',
              ),
            ),
            IconButton(
              constraints: BoxConstraints(),
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_ios, color: AppTheme.textColor),
            ),
          ],
        ),
      ],
    );
  }
}
