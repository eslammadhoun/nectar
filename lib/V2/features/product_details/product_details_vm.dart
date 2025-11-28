import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nectar/V2/Data/models/product_model.dart';
import 'package:nectar/V2/Data/repositories/cart_repo.dart';
import 'package:nectar/V2/Data/repositories/favorite_repo.dart';

class ProductDetailsVm extends ChangeNotifier {
  final CartRepo cartRepo;
  final FavoriteRepo favoriteRepo;

  ProductDetailsVm({required this.cartRepo, required this.favoriteRepo});

  int selectedImg = 0;
  bool isFav = false;
  int quantity = 1;
  bool isAddedToCart = false;

  void changeSelectedImg(index) {
    selectedImg = index;
    notifyListeners();
  }

  void incrementQuantity(BuildContext context, String productId) async {
    try {
      quantity++;
      notifyListeners();
      await cartRepo.incrementQuantity(productId);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('error: $e')));
      }
    }
  }

  void deIncrementQuantity(BuildContext context, String productId) async {
    if (quantity > 1 && isAddedToCart) {
      try {
        quantity--;
        notifyListeners();
        await cartRepo.deincrementQuantity(productId);
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('error: $e')));
        }
      }
    }
  }

  Future<void> getProductQuantity(String productId) async {
    try {
      quantity = await cartRepo.getProductQuantity(productId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error getting product quantity: $e');
    }
  }

  Future<void> checkIfFavorite(String productId) async {
    try {
      isFav = await favoriteRepo.checkIfFavorite(productId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error checking favorite: $e');
    }
  }

  Future<void> toggleFavoriteStatus(ProductModel product) async {
    isFav = !isFav;
    notifyListeners();
    try {
      await favoriteRepo.toggleFavoriteStatus(product);
    } catch (e) {
      isFav = !isFav;
      notifyListeners();
      debugPrint('Error toggling favorite: $e');
    }
  }

  Future<void> checkIsInCart(String productId) async {
    try {
      isAddedToCart = await cartRepo.checkIsInCart(productId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error checking cart status: $e');
    }
  }

  Future<void> toggleAddingToCart(ProductModel product) async {
    try {
      if (isAddedToCart) {
        await cartRepo.deleteFromCart(product.productId);
        isAddedToCart = false;
        notifyListeners();
      } else {
        await cartRepo.saveProductToCart(product, quantity, Timestamp.now());
        
        isAddedToCart = true;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error toggling cart: $e');
    }
  }
}
