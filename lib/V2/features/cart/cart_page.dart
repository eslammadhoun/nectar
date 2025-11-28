import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nectar/V2/Data/models/product_model.dart';
import 'package:nectar/V2/features/cart/cart_page_vm.dart';
import 'package:nectar/V2/features/order_accepted/order_accepted_page.dart';
import 'package:nectar/V2/features/widgets/bottom_sheet_item.dart';
import 'package:nectar/V2/features/widgets/cart_product/cart_product.dart';
import 'package:provider/provider.dart';
import 'package:nectar/V2/Core/theme/app_theme.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void showBottomSheet(CartPageVm vm,double finalCost) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.55,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Checkout",
                    style: TextStyle(
                      color: AppTheme.textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                  IconButton(
                    constraints: BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, color: AppTheme.textColor),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(height: 1, color: Color(0xffE2E2E2)),
              ),
              BottomSheetItem(name: "Delivery", operation: 'Select Method'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(height: 1, color: Color(0xffE2E2E2)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Payment",
                    style: TextStyle(
                      color: AppTheme.secondaryText,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/visacardicon.svg"),
                      IconButton(
                        constraints: BoxConstraints(),
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: AppTheme.textColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(height: 1, color: Color(0xffE2E2E2)),
              ),
              BottomSheetItem(name: 'Promo Code', operation: 'Pick discount'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(height: 1, color: Color(0xffE2E2E2)),
              ),
              BottomSheetItem(
                name: 'Total Cost',
                operation: '\$${finalCost.toStringAsFixed(2)}',
              ),
              Text(
                "By placing an order you agree to our",
                style: TextStyle(
                  color: AppTheme.secondaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gilroy',
                ),
              ),
              Row(
                children: [
                  Text(
                    "Terms ",
                    style: TextStyle(
                      color: AppTheme.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                  Text(
                    "And ",
                    style: TextStyle(
                      color: AppTheme.secondaryText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                  Text(
                    "Conditions",
                    style: TextStyle(
                      color: AppTheme.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  await vm.deleteCart();
                  if (context.mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => OrderAcceptedPage(),
                      ),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  width: MediaQuery.of(context).size.width - 50,
                  height: 67,
                  decoration: BoxDecoration(
                    color: AppTheme.mainColor,
                    borderRadius: BorderRadius.circular(19),
                  ),
                  child: Center(
                    child: Text(
                      "Place Order",
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
            ],
          ),
        );
      },
    );
  }

  Widget cartProductsList(
      CartPageVm vm,
    Stream<List<ProductModel>> cartProductsStream,
    Stream<double> finalCostStream,
  ) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: StreamBuilder<List<ProductModel>>(
          stream: cartProductsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error loading cart products: ${snapshot.error.toString()}",
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Cart is Empty'));
            } else {
              final List<ProductModel> products = snapshot.data!;
              return Stack(
                children: <Widget>[
                  ListView.separated(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final ProductModel product = products[index];
                      return CartProduct(product: product);
                    },
                    separatorBuilder: (context, index) {
                      return Container(height: 1, color: Color(0xffE2E2E2));
                    },
                  ),
                  Positioned(
                    bottom: 25,
                    child: StreamBuilder(
                      stream: finalCostStream,
                      builder: (context, snapshot) {
                        final cost = snapshot.data ?? 0.0;
                        return GestureDetector(
                          onTap: () {
                            showBottomSheet(vm,cost);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            width: MediaQuery.of(context).size.width - 50,
                            height: 67,
                            decoration: BoxDecoration(
                              color: AppTheme.mainColor,
                              borderRadius: BorderRadius.circular(19),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const SizedBox(width: 45, height: 22),
                                  const Text(
                                    "Go to Checkout",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Gilroy',
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(7),
                                    height: 34,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff4AA069),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: StreamBuilder<double>(
                                      stream: finalCostStream,
                                      builder: (
                                        BuildContext context,
                                        AsyncSnapshot<dynamic> snapshot,
                                      ) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else if (snapshot.hasData != true) {
                                          return Center(child: Text('0.0'));
                                        } else {
                                          return Text(
                                            "${cost.toStringAsFixed(2)}\$",
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartPageVm>(
      builder: (context, vm, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 8),
                Text(
                  "My Cart",
                  style: TextStyle(
                    color: AppTheme.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Container(height: 1, color: const Color(0xffE2E2E2)),
                cartProductsList(vm, vm.cartProductsStream, vm.finalCostStream),
              ],
            ),
          ),
        );
      },
    );
  }
}