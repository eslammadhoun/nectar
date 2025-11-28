import 'package:flutter/material.dart';
import 'package:nectar/V2/Core/theme/app_theme.dart';
import 'package:nectar/V2/Data/models/product_model.dart';
import 'package:nectar/V2/features/category/catecory_vm.dart';
import 'package:nectar/V2/features/widgets/product_card/product_card.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({
    super.key,
    required this.productCategoryName,
    required this.catecoryCollectionName,
  });
  final String productCategoryName;
  final String catecoryCollectionName;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      final vm = Provider.of<CategoryPageVm>(context, listen: false);
      vm.getProducts(widget.catecoryCollectionName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryPageVm>(
      builder: (context, vm, child) {
        return Scaffold(
          body: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 25),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      constraints: BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                    Text(
                      widget.productCategoryName,
                      style: TextStyle(
                        color: AppTheme.textColor,
                        fontSize: 20,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      constraints: BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: Icon(Icons.tune, color: AppTheme.textColor),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                vm.isLoading
                    ? Center(child: CircularProgressIndicator(color: AppTheme.mainColor,))
                    : GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.68,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                      ),
                      itemCount: vm.listOfProducts.length,
                      itemBuilder: (context, index) {
                        final ProductModel product = vm.listOfProducts[index];
                        return ProductCard(product: product);
                      },
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}
