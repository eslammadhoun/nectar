import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nectar/V2/Data/models/product_model.dart';

class ProductsRepo {
  Future<List<ProductModel>> getProducts(String collectionName) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> productsQuerySnapshot =
          await FirebaseFirestore.instance.collection(collectionName).get();
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> productsDocs =
          productsQuerySnapshot.docs;
      return productsDocs
          .map((eachProductDoc) => ProductModel.fromJson(eachProductDoc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
