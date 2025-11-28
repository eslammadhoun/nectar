import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nectar/V2/Data/models/product_model.dart';
import 'package:nectar/V2/Data/repositories/cart_repo.dart';

class ProductCardVm extends ChangeNotifier {
  final CartRepo cartRepo;

  ProductCardVm({required this.cartRepo});

  List<ProductModel> cartProducts = [];

  Future<String?> saveProductToCart(
    ProductModel product,
    int quantity,
    Timestamp timestamp,
  ) async {
    try {
      String? message = await cartRepo.saveProductToCart(
        product,
        quantity,
        timestamp,
      );
      return message;
    } catch (e) {
      debugPrint('Error saving to cart: $e');
      return null;
    }
  }
}
