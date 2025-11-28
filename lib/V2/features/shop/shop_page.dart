import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nectar/V2/Core/theme/app_theme.dart';
import 'package:nectar/V2/Data/models/product_model.dart';
import 'package:nectar/V2/features/shop/shop_page_vm.dart';
import 'package:nectar/V2/features/widgets/product_card/product_card.dart';
import 'package:nectar/V2/features/widgets/search_field.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final vm = Provider.of<ShopPageVm>(context, listen: false);
      vm.fetchData();
    });
  }

  Widget locationSection(vm) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 75, bottom: 10),
          child: SvgPicture.asset('assets/icons/appiconfilled.svg'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.location_pin, color: Color(0xff4C4F4D), size: 30),
              Text(
                vm.userLocation,
                style: TextStyle(
                  color: Color(0xFF4C4F4D),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gilroy',
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        SearchField(),
        SizedBox(height: 20),
      ],
    );
  }

  Widget dailyAdsSection(vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xffF2F3F2), width: 1),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              onPageChanged:
                  (index) => setState(() {
                    vm.selectedbanner = index;
                  }),
              children: [
                Image.asset('assets/images/banner#1.png', fit: BoxFit.cover),
                Image.asset('assets/images/banner#2.png', fit: BoxFit.cover),
                Image.asset('assets/images/banner#3.png', fit: BoxFit.cover),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  final bool isSelected = vm.selectedbanner == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 3.5),
                    width: isSelected ? 17 : 5,
                    height: isSelected ? 6 : 5,
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? AppTheme.mainColor
                              : const Color(0xFF030303).withOpacity(0.30),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGenericSection(
    String sectionTitle,
    List<ProductModel> list,
    bool isLoading,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionTitle,
                style: TextStyle(
                  color: AppTheme.textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gilroy',
                ),
              ),
              Text(
                "See all",
                style: TextStyle(
                  color: AppTheme.mainColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gilroy',
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 250,
            child:
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : list.isEmpty
                    ? const Center(child: Text("No products available"))
                    : ListView.separated(
                      padding: const EdgeInsets.only(left: 0),
                      scrollDirection: Axis.horizontal,
                      itemCount: list.length,
                      separatorBuilder:
                          (context, index) => const SizedBox(width: 15),
                      itemBuilder: (context, index) {
                        final product = list[index];
                        return ProductCard(product: product);
                      },
                    ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget groceriesSection() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Groceries",
                style: TextStyle(
                  color: AppTheme.textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gilroy',
                ),
              ),
              Text(
                "See all",
                style: TextStyle(
                  color: AppTheme.mainColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gilroy',
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: SizedBox(
            height: 105,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 17),
                  width: (MediaQuery.of(context).size.width - 39) * 0.70,
                  decoration: BoxDecoration(
                    color: Color(0xffF8A44C).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/images/Groceries#1.png'),
                      SizedBox(width: 15),
                      Text(
                        "Pulses",
                        style: TextStyle(
                          color: Color(0xFF3E423F),
                          fontSize: 20,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  padding: EdgeInsets.only(left: 17),
                  width: (MediaQuery.of(context).size.width - 39) * 0.70,
                  decoration: BoxDecoration(
                    color: Color(0xff53B175).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/images/Groceries#2.png'),
                      SizedBox(width: 15),
                      Text(
                        "Rice",
                        style: TextStyle(
                          color: Color(0xFF3E423F),
                          fontSize: 20,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopPageVm>(
      builder: (context, vm, child) {
        return ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            locationSection(vm),
            dailyAdsSection(vm),
            SizedBox(height: 30),
            buildGenericSection(
              'Exclusive Offer',
              vm.exclusiveOfferProductsList,
              vm.isLoadingExclusiveOffers,
            ),
            buildGenericSection(
              'Best Selling',
              vm.bestSellingProducts,
              vm.isLoadingBestSelling,
            ),
            groceriesSection(),
            buildGenericSection('Meets', vm.meetsProducts, vm.isLoadingMeets),
          ],
        );
      },
    );
  }
}