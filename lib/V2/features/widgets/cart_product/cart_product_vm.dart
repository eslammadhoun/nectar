import 'package:flutter/cupertino.dart';
import 'package:nectar/V2/Data/repositories/cart_repo.dart';

class CartProductVm extends ChangeNotifier {
  final CartRepo cartRepo;
  CartProductVm({required this.cartRepo});


  Future<void> incrementQuantity(String productId) async {
    await cartRepo.incrementQuantity(productId);
  }

  Future<void> deincrementQuantity(String productId) async {
    await cartRepo.deincrementQuantity(productId);
  }

  Future<void> deleteFromCart(String productId) async {
    await cartRepo.deleteFromCart(productId);
    notifyListeners();
  }
}