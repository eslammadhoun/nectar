import 'package:flutter/material.dart';
import 'package:nectar/V2/Data/models/product_model.dart';
import 'package:nectar/V2/Data/repositories/products_repo.dart';

class CategoryPageVm extends ChangeNotifier {
  final ProductsRepo productsRepo;

  CategoryPageVm({required this.productsRepo});

  bool isLoading = false;
  List<ProductModel> listOfProducts = [];

  Future<void> getProducts(String catecoryCollectionName) async {
    isLoading = true;
    notifyListeners();
    try {
      listOfProducts = await productsRepo.getProducts(catecoryCollectionName);
    } catch (e) {
      debugPrint('Error fetching category products: $e');
    }
    isLoading = false;
    notifyListeners();
  }
}