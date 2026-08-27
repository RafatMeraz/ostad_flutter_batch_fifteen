class ProductModel {
  final String id;
  final String title;
  final List<String> photos;
  final int currentPrice;
  final int quantity;
  final double rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.photos,
    required this.currentPrice,
    required this.quantity,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> jsonData) {
    return ProductModel(
      id: jsonData['_id'],
      title: jsonData['title'],
      photos: List.from(jsonData['photos']),
      currentPrice: jsonData['current_price'],
      quantity: jsonData['quantity'],
      rating: 4.5,
    );
  }
}
