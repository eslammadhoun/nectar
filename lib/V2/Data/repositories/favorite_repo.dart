import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nectar/V2/Data/models/product_model.dart';

class FavoriteRepo {
  String get _userId {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('User not logged in');
    return user.uid;
  }

  CollectionReference<Map<String, dynamic>> get _favoriteCollection =>
      FirebaseFirestore.instance
          .collection('Users')
          .doc(_userId)
          .collection('Favorite_products');

  Stream<List<ProductModel>> getFavProductsStream() {
    try {
      return _favoriteCollection.snapshots().map((snapshot) {
        return snapshot.docs.map((eachDoc) {
          return ProductModel.fromJson(eachDoc.data());
        }).toList();
      });
    } catch (e) {
      throw Exception('Failed to fetch Favourtie products: $e');
    }
  }

  Future<bool> checkIfFavorite(String productId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _favoriteCollection.doc(productId).get();
      return documentSnapshot.exists;
    } catch (e) {
      throw Exception('Failed to check favorite status: $e');
    }
  }

  Future<void> toggleFavoriteStatus(ProductModel product) async {
    try {
      final DocumentReference<Map<String, dynamic>> productDocReference =
          _favoriteCollection.doc(product.productId);
          
      final docSnapshot = await productDocReference.get();
      if (docSnapshot.exists) {
        await productDocReference.delete();
      } else {
        await productDocReference.set({
          'product_id' : product.productId,
          'product_name' : product.productName,
          'product_desc' : product.productDescription,
          'product_cost' : product.productCost,
          'product_image_url' : product.productImageUrl,
          'timestamp' : Timestamp.now(),
          'isFav' : true
        });
      }
    } catch (e) {
      throw Exception('Failed to toggle favorite status: $e');
    }
  }
}
