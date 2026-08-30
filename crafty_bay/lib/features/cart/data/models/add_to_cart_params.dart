class AddToCartParams {
  final String productId;
  final String color;
  final String size;
  final int quantity;

  AddToCartParams({
    required this.productId,
    required this.color,
    required this.size,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      "product": productId,
      "color": color,
      "size": size,
      "quantity": quantity,
    };
  }
}
