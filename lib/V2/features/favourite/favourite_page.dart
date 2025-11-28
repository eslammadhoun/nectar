import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nectar/V2/Core/theme/app_theme.dart';
import 'package:nectar/V2/Data/models/product_model.dart';
import 'package:provider/provider.dart';

import '../widgets/favorurite_product_card.dart';
import 'favourite_page_vm.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  void showSafeSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouritePageVm>(
      builder: (context, vm, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    "Favourite",
                    style: TextStyle(
                      color: AppTheme.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(height: 1, color: const Color(0xffE2E2E2)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: StreamBuilder<List<ProductModel>>(
                      stream: vm.getFavProductsStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text("Error loading Favourite Page."),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text("Nothing in Favourite."),
                          );
                        } else {
                          final List<ProductModel> products = snapshot.data!;
                          return Stack(
                            children: [
                              ListView.separated(
                                padding: EdgeInsets.only(bottom: 60),
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  final product = products[index];
                                  return Dismissible(
                                    key: UniqueKey(),
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      color: Colors.red,
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onDismissed: (direction) async {
                                      await vm.deleteProductFromFav(product);
                                      showSafeSnackBar(
                                        'Product Deleted from Favourite',
                                      );
                                    },
                                    child: FavouriteProductCard(
                                      product: product,
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (context, index) => Container(
                                      height: 1,
                                      color: const Color(0xffE2E2E2),
                                    ),
                              ),
                              Positioned(
                                bottom: 25,
                                child: GestureDetector(
                                  onTap: () async {
                                    vm.addAllToCart(products);
                                    showSafeSnackBar('All Products Added To Cart');
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width - 50,
                                    height: 67,
                                    decoration: BoxDecoration(
                                      color: AppTheme.mainColor,
                                      borderRadius: BorderRadius.circular(19),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Add All To Cart",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Gilroy',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
