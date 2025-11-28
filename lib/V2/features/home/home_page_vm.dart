import 'package:flutter/material.dart';
import 'package:nectar/V2/features/account/account_page.dart';
import 'package:nectar/V2/features/cart/cart_page.dart';
import 'package:nectar/V2/features/explore/explore_page.dart';
import 'package:nectar/V2/features/favourite/favourite_page.dart';
import 'package:nectar/V2/features/shop/shop_page.dart';

class HomePageVm extends ChangeNotifier {
  int selectedIndex = 0;
  
  static const List<Widget> _pages = [
    ShopPage(),
    ExplorePage(),
    CartPage(),
    FavouritePage(),
    AccountPage(),
  ];

  List<Widget> get pages => _pages;

  onItemTapped(int newIndex) {
    selectedIndex = newIndex;
    notifyListeners();
  }
}
