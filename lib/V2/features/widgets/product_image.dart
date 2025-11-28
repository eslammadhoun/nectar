import 'dart:ui';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 45, sigmaY: 45),
            child: Image.network(
              imageUrl,
              width: 200,
              height: 150,
              fit: BoxFit.contain,
            ),
          ),
          Image.network(
            imageUrl,
            fit: BoxFit.contain,
            width: 300,
            height: 200,
          ),
        ],
      ),
    );
  }
}
