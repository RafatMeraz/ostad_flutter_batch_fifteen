import 'package:flutter/material.dart';

import '../../../shared/presentation/widgets/product_item.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  const ProductsByCategoryScreen({super.key, required this.categoryName});

  static const String name = '/products-by-category';

  final String categoryName;

  @override
  State<ProductsByCategoryScreen> createState() =>
      _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName)),
      body: GridView.builder(
        itemCount: 30,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 0,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          // TODO: Fix the UI with Aspect Ratio
          return FittedBox(child: ProductItem());
        },
      ),
    );
  }
}
