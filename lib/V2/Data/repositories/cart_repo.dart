import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nectar/V2/Data/models/product_model.dart';

class CartRepo {
  String get _userId {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('User not logged in');
    return user.uid;
  }

  CollectionReference<Map<String, dynamic>> get _cartCollection =>
      FirebaseFirestore.instance
          .collection('Users')
          .doc(_userId)
          .collection('Cart_products');

  Stream<List<ProductModel>> getCartProductsStream() {
    try {
      return _cartCollection.snapshots().map((snapshot) {
        return snapshot.docs.map((eachDoc) {
          return ProductModel.fromJson(eachDoc.data());
        }).toList();
      });
    } catch (e) {
      throw Exception('Failed to fetch cart products: $e');
    }
  }

  Stream<double> finalCostStream() {
    try {
      return _cartCollection.snapshots().map((snapshot) {
        double finalCost = 0;
        List<ProductModel> cartProducts =
            snapshot.docs.map((eachDoc) {
              return ProductModel.fromJson(eachDoc.data());
            }).toList();

        if (cartProducts.isNotEmpty) {
          for (ProductModel product in cartProducts) {
            final double cost = double.tryParse(product.productCost) ?? 0;
            final int quantity = product.quantity ?? 1;
            finalCost += cost * quantity;
          }
          return finalCost;
        } else {
          return 0.0;
        }
      });
    } catch (e) {
      throw Exception('Failed to fetch cart products: $e');
    }
  }

  Future<void> deleteAllCart() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> collection = await _cartCollection.get();
      for (QueryDocumentSnapshot doc in collection.docs) {
        await doc.reference.delete();
      }
    } catch  (e) {
      throw Exception('Failed to delete cart: $e');
    }
  }

  Future<void> incrementQuantity(String productId) async {
    try {
      final DocumentReference docReference = _cartCollection.doc(productId);
      final DocumentSnapshot docSnapshot = await docReference.get();
      if (!docSnapshot.exists) return;
      await docReference.update({'quantity': FieldValue.increment(1)});
    } catch (e) {
      throw Exception('Failed to increment quantity: $e');
    }
  }

  Future<void> deincrementQuantity(String productId) async {
    try {
      final DocumentReference documentReference = _cartCollection.doc(
        productId,
      );
      final DocumentSnapshot documentSnapshot = await documentReference.get();
      if (!documentSnapshot.exists) return;
      await documentReference.update({'quantity': FieldValue.increment(-1)});
    } catch (e) {
      throw Exception('Failed to decrement quantity: $e');
    }
  }

  Future<int> getProductQuantity(String productId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _cartCollection.doc(productId).get();
      if (documentSnapshot.exists) {
        final productData = documentSnapshot.data();
        return productData!['quantity'] ?? 1;
      } else {
        return 1;
      }
    } catch (e) {
      throw Exception('Failed to get product quantity: $e');
    }
  }

  Future<String?> saveProductToCart(
    ProductModel product,
    int quantity,
    Timestamp timestamp,
  ) async {
    try {
      await _cartCollection.doc(product.productId).set({
        ...product.toJson(),
        'quantity': quantity,
        'timestamp': timestamp,
      });

      return 'Product Added to Cart';
    } catch (e) {
      throw Exception('Failed to save product to cart: $e');
    }
  }

  Future<bool> checkIsInCart(String productId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _cartCollection.doc(productId).get();
      return documentSnapshot.exists;
    } catch (e) {
      throw Exception('Failed to check if in cart: $e');
    }
  }

  Future<void> deleteFromCart(String productId) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          _cartCollection.doc(productId);
      await documentReference.delete();
    } catch (e) {
      throw Exception('Failed to delete from cart: $e');
    }
  }
}
