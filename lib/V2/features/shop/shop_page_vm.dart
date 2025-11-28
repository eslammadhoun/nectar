import 'package:flutter/material.dart';
import 'package:nectar/V2/Data/models/product_model.dart';
import 'package:nectar/V2/Data/repositories/products_repo.dart';
import 'package:nectar/V2/Data/services/location_service.dart';

class ShopPageVm extends ChangeNotifier {
  final ProductsRepo productsRepo;

  ShopPageVm({required this.productsRepo});

  String userLocation = 'Location...';
  int selectedbanner = 0;
  List<ProductModel> exclusiveOfferProductsList = [];
  bool isLoadingExclusiveOffers = false;
  List<ProductModel> bestSellingProducts = [];
  bool isLoadingBestSelling = false;
  List<ProductModel> meetsProducts = [];
  bool isLoadingMeets = false;

  Future<void> getCurrentUserLocation() async {
    final String fetchdLocation =
        await LocationService.getCurrentUserLocation();
    userLocation = fetchdLocation;
    notifyListeners();
  }

  Future<void> getExclusiveOfferProducts() async {
    isLoadingExclusiveOffers = true;
    notifyListeners();
    try {
      List<ProductModel> list = await productsRepo.getProducts('Exclusive_offer_products');
      exclusiveOfferProductsList = list;
    } catch (e) {
      debugPrint('Error fetching exclusive offers: $e');
    }
    isLoadingExclusiveOffers = false;
    notifyListeners();
  }

  Future<void> getBestSellingProducts() async {
    isLoadingBestSelling = true;
    notifyListeners();
    try {
      List<ProductModel> list = await productsRepo.getProducts(
        'Best_selling_products',
      );
      bestSellingProducts = list;
    } catch (e) {
      debugPrint('Error fetching best selling products: $e');
    }
    isLoadingBestSelling = false;
    notifyListeners();
  }

  Future<void> getMeetsProducts() async {
    isLoadingMeets = true;
    notifyListeners();
    try {
      List<ProductModel> list = await productsRepo.getProducts('meets');
      meetsProducts = list;
    } catch (e) {
      debugPrint('Error fetching meets products: $e');
    }
    isLoadingMeets = false;
    notifyListeners();
  }

  Future<void> fetchData() async {
    getExclusiveOfferProducts();
    getCurrentUserLocation();
    getBestSellingProducts();
    getMeetsProducts();
  }
}
