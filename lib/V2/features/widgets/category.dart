import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final String iamgeUrl;
  final String categoryName;
  final Color categoryColor;
  final Function()? onTap;

  const Category({
    super.key,
    required this.iamgeUrl,
    required this.categoryName,
    required this.categoryColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: categoryColor.withOpacity(0.10),
          border: Border.all(color: categoryColor.withOpacity(0.70), width: 1),
          borderRadius: BorderRadius.circular(18),
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Image.asset(iamgeUrl),
            SizedBox(height: 25),
            Text(
              textAlign: TextAlign.center,
              categoryName,
              style: TextStyle(
                color: Color(0xff181725),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Gilroy',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
