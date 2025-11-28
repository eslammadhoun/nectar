import 'package:flutter/material.dart';
import 'package:nectar/V2/Data/models/product_model.dart';
import 'package:nectar/V2/Data/repositories/cart_repo.dart';

class CartPageVm extends ChangeNotifier {
  final CartRepo cartRepo;
  CartPageVm({required this.cartRepo});

  Stream<List<ProductModel>> get cartProductsStream =>
      cartRepo.getCartProductsStream();

  Stream<double> get finalCostStream => cartRepo.finalCostStream();

  Future<void> deleteCart() async {
    await cartRepo.deleteAllCart();
  }
}
