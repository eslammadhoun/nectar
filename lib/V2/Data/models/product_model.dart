import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String productId;
  String productName;
  String productDescription;
  String productImageUrl;
  String productCost;
  bool isFav;
  int? quantity;
  Timestamp? timestamp;


  ProductModel({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productImageUrl,
    required this.productCost,
    required this.isFav,
    this.quantity,
    this.timestamp
  });

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['product_id'],
      productName: map['product_name'],
      productDescription: map['product_desc'],
      productImageUrl: map['product_image_url'],
      productCost: map['product_cost'],
      isFav: map['isFav'],
      quantity: map['quantity'] ?? 1,
      timestamp: map['timestamp']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id' : productId,
      'product_name' : productName,
      'product_desc' : productDescription,
      'product_image_url' : productImageUrl,
      'product_cost' : productCost,
      'isFav' : isFav,
      'quantity' : quantity ?? 1,
      'timestamp' : timestamp
    };
  }
}
