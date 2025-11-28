import 'package:flutter/material.dart';
import 'package:nectar/V2/Core/theme/app_theme.dart';
import 'package:nectar/V2/Data/models/product_model.dart';
import 'package:nectar/V2/features/product_details/product_details_vm.dart';
import 'package:nectar/V2/features/widgets/product_image.dart';
import 'package:provider/provider.dart';

import '../widgets/expandable_section.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final vm = Provider.of<ProductDetailsVm>(context, listen: false);
      await Future.wait([
        vm.checkIsInCart(widget.product.productId),
        vm.getProductQuantity(widget.product.productId),
        vm.checkIfFavorite(widget.product.productId),
      ]);
    });
  }

  Widget _productImagesSection(vm) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF2F3F2),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 60),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_ios),
                ),
                Icon(Icons.ios_share_outlined, color: AppTheme.textColor),
              ],
            ),
          ),
          SizedBox(height: 28),
          SizedBox(
            height: 240,
            child: PageView(
              children: List.generate(
                3,
                (index) =>
                    ProductImage(imageUrl: widget.product.productImageUrl),
              ),
              onPageChanged: (index) => vm.changeSelectedImg(index),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30, top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                final bool isSelected = index == vm.selectedImg;
                return AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  margin: EdgeInsets.symmetric(horizontal: 3.5),
                  width: isSelected ? 17 : 5,
                  height: isSelected ? 6 : 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:
                        isSelected
                            ? AppTheme.mainColor
                            : const Color(0xFF030303).withOpacity(0.30),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productInfoSection(vm) {
    return Column(
      children: [
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.productName,
                  style: TextStyle(
                    color: AppTheme.textColor,
                    fontSize: 24,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  widget.product.productDescription,
                  style: TextStyle(
                    color: Color(0xff7C7C7C),
                    fontSize: 16,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
            IconButton(
              onPressed: () => vm.toggleFavoriteStatus(widget.product),
              icon: Icon(
                vm.isFav ? Icons.favorite : Icons.favorite_outline,
                color: vm.isFav ? Colors.red : null,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap:
                      () => vm.deIncrementQuantity(
                        context,
                        widget.product.productId,
                      ),
                  child: Icon(Icons.remove, color: Color(0xffB3B3B3), size: 30),
                ),
                SizedBox(width: 20),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Color(0xffE2E2E2), width: 1),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Center(
                    child: Text(
                      vm.quantity.toString(),
                      style: TextStyle(
                        color: AppTheme.textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap:
                      () => vm.incrementQuantity(
                        context,
                        widget.product.productId,
                      ),
                  child: Icon(Icons.add, color: AppTheme.mainColor, size: 30),
                ),
              ],
            ),
            Text(
              '\$${widget.product.productCost}',
              style: TextStyle(
                color: AppTheme.textColor,
                fontSize: 24,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        Container(height: 1.5, color: Color(0xffE2E2E2)),
        SizedBox(height: 18),
      ],
    );
  }

  Widget _productExpandableSection() {
    return Column(
      children: [
        ExpandableSection(
          title: "Product Detail",
          child: Text(
            'Apples are nutritious. Apples may be good for weight loss. apples may be good for your heart. As part of a healtful and varied diet.',
            style: TextStyle(
              color: Color(0xff7C7C7C),
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ExpandableSection(
          title: 'Nutritions',
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '100gr',
              style: TextStyle(
                color: Color(0xff7C7C7C),
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          child: Text('• Protein: 1g\n• Fat: 0g\n• Carbs: 25g'),
        ),
        ExpandableSection(
          title: 'Review',
          trailing: Row(
            children: List.generate(
              5,
              (index) => const Icon(Icons.star, size: 16, color: Colors.orange),
            ),
          ),
          child: Text('Very tasty and fresh apples! Loved it.'),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buttonSection(vm) {
    return GestureDetector(
      child: Container(
        height: 67,
        decoration: BoxDecoration(
          color: AppTheme.mainColor,
          borderRadius: BorderRadius.circular(19),
        ),
        child: Center(
          child: Text(
            (vm.isAddedToCart) ? "Remove from Basket" : "Add To Basket",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Gilroy',
            ),
          ),
        ),
      ),
      onTap: () async {
        vm.toggleAddingToCart(widget.product);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                vm.isAddedToCart
                    ? "Product Removed from Basket"
                    : "Product Added to Basket",
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailsVm>(
      builder: (context, vm, child) {
        return Scaffold(
          body: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              _productImagesSection(vm),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _productInfoSection(vm),
                    _productExpandableSection(),
                  ],
                ),
              ),
              _buttonSection(vm),
            ],
          ),
        );
      },
    );
  }
}
