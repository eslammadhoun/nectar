import 'package:flutter/material.dart';
import 'package:nectar/V2/Core/theme/app_theme.dart';
import 'package:nectar/V2/features/widgets/category.dart';
import 'package:nectar/V2/features/category/category_page.dart';

import '../widgets/search_field.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  static const List<Map<String, dynamic>> categoriesList = [
    {
      'catecoryName': 'Frash Fruits\n& Vegetable',
      'catecoryColor': Color(0xff53B175),
      'catecoryImagePath': 'assets/images/category#1.png',
      'catecoryNextRoute': 'Frash Fruits & Vegetable',
      'categoryCollectionName' : 'Fruits_and_vegetables'
    },
    {
      'catecoryName': 'Cooking Oil\n& Ghee',
      'catecoryColor': Color(0xffF8A44C),
      'catecoryImagePath': 'assets/images/category#2.png',
      'catecoryNextRoute': 'Cooking Oil & Ghee',
      'categoryCollectionName' : 'Cooking Oil & Ghee'
    },
    {
      'catecoryName': 'Meat & Fish',
      'catecoryColor': Color(0xffF7A593),
      'catecoryImagePath': 'assets/images/category#3.png',
      'catecoryNextRoute': 'Meat& Fish',
      'categoryCollectionName' : 'meets'
    },
    {
      'catecoryName': 'Bakery & Snacks',
      'catecoryColor': Color(0xffD3B0E0),
      'catecoryImagePath': 'assets/images/category#4.png',
      'catecoryNextRoute': 'Bakery & Snacks',
      'categoryCollectionName' : 'Bakery & Snacks'
    },
    {
      'catecoryName': 'Dairy & Eggs',
      'catecoryColor': Color(0xffFDE598),
      'catecoryImagePath': 'assets/images/category#5.png',
      'catecoryNextRoute': 'Dairy & Eggs',
      'categoryCollectionName' : 'Dairy&Eggs'
    },
    {
      'catecoryName': 'Beverages',
      'catecoryColor': Color(0xffB7DFF5),
      'catecoryImagePath': 'assets/images/category#6.png',
      'catecoryNextRoute': 'Beverages',
      'categoryCollectionName' : 'Beverages'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 14),
            child: Center(
              child: Text(
                "Find Products",
                style: TextStyle(
                  color: AppTheme.textColor,
                  fontSize: 20,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 18),
          SearchField(),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              shrinkWrap: true,
              childAspectRatio: 0.85,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(6, (index) {
                final Map<String, dynamic> data = categoriesList[index];
                return Category(
                  iamgeUrl: data['catecoryImagePath'],
                  categoryName: data['catecoryName'],
                  categoryColor: data['catecoryColor'],
                  onTap:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => CategoryPage(
                                productCategoryName: data['catecoryNextRoute'],
                                catecoryCollectionName: data['categoryCollectionName'],
                              ),
                        ),
                      ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}