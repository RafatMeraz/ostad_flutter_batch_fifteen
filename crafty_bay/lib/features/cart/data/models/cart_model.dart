import 'package:crafty_bay/features/products/models/product_model.dart';

class CartModel {
  final String id;
  final ProductModel product;
  int quantity;
  final String? color;
  final String? size;

  CartModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.color,
    required this.size,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['_id'],
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
      color: json['color'],
      size: json['size'],
    );
  }
}
