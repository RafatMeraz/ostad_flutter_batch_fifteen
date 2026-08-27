import 'package:flutter/material.dart';

import '../../../shared/presentation/widgets/product_item.dart';

class HomeProductsSection extends StatelessWidget {
  const HomeProductsSection({super.key, required this.products});

  final List<String> products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: .horizontal,
        itemBuilder: (context, index) {
          // return ProductItem();
        },
      ),
    );
  }
}
