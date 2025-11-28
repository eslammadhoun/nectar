import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nectar/V2/Core/theme/app_theme.dart';
import 'package:nectar/V2/Data/models/product_model.dart';
import 'package:nectar/V2/features/widgets/cart_product/cart_product_vm.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final ProductModel product;
  const CartProduct({super.key, required this.product});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  void initState() {
    super.initState();
    final vm = Provider.of<CartProductVm>(context, listen: false);
    // vm.quantity = widget.product.quantity ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProductVm>(
      builder: (context, vm, child) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: SizedBox(
            height: 120,
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 120,
                      child: Image.network(widget.product.productImageUrl),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.productName,
                            style: TextStyle(
                              color: AppTheme.textColor,
                              fontFamily: 'Gilroy',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.product.productDescription,
                            style: TextStyle(
                              color: AppTheme.secondaryText,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async{
                                      await vm.deincrementQuantity(widget.product.productId);
                                    },
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(17),
                                        border: Border.all(
                                          color: Color(0xffF0F0F0),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.remove,
                                        color: Color(0xffB3B3B3),
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    widget.product.quantity.toString() ?? '1',
                                    style: TextStyle(
                                      color: AppTheme.textColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  GestureDetector(
                                    onTap: () async {
                                      await vm.incrementQuantity(widget.product.productId);
                                    },
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(17),
                                        border: Border.all(
                                          color: Color(0xffF0F0F0),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: AppTheme.mainColor,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "\$${widget.product.productCost}",
                                style: TextStyle(
                                  color: AppTheme.textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Color(0xffB3B3B3)),
                    onPressed: () async => await vm.deleteFromCart(widget.product.productId)
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