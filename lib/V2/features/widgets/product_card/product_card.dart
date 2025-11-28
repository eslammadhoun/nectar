import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nectar/V2/Core/theme/app_theme.dart';
import 'package:nectar/V2/Data/models/product_model.dart';
import 'package:nectar/V2/features/product_details/product_detail_page.dart';
import 'package:nectar/V2/features/widgets/product_card/product_card_vm.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(product: product),
            ),
          ),
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 32,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Color(0xffE2E2E2), width: 1.5),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Image.network(
                  product.productImageUrl,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.mainColor,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              product.productName,
              style: TextStyle(
                color: AppTheme.textColor,
                fontSize: 16,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 5),
            Text(
              product.productDescription,
              style: TextStyle(
                color: Color(0xff707070),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${product.productCost} \$",
                  style: TextStyle(
                    color: Color(0xFF181725),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gilroy',
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: AppTheme.mainColor,
                    ),
                    child: Center(child: Icon(Icons.add, color: Colors.white)),
                  ),
                  onTap: () async {
                    String? messsage = await Provider.of<ProductCardVm>(
                      context,
                      listen: false,
                    ).saveProductToCart(product, 1, Timestamp.now());
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            messsage ?? 'Faild Please Try Again Later...',
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
