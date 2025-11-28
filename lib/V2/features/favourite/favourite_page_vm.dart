import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:nectar/V2/Data/models/product_model.dart';
import 'package:nectar/V2/Data/repositories/cart_repo.dart';
import 'package:nectar/V2/Data/repositories/favorite_repo.dart';

class FavouritePageVm extends ChangeNotifier {
  final FavoriteRepo favRepo;
  final CartRepo cartRepo;
  FavouritePageVm({required this.favRepo, required this.cartRepo});

  Stream<List<ProductModel>> get getFavProductsStream =>
      favRepo.getFavProductsStream();

  Future<void> deleteProductFromFav(ProductModel product) async =>
      favRepo.toggleFavoriteStatus(product);

  Future<void> addAllToCart(List<ProductModel> listOfProducts) async {
    for (ProductModel eachProduct in listOfProducts) {
      await cartRepo.saveProductToCart(eachProduct, 1, Timestamp.now());
    }
  }
}
