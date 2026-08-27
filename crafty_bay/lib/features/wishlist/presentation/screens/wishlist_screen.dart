import 'package:flutter/material.dart';

import '../../../shared/presentation/widgets/product_item.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  static const String name = '/wishlist';

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wishlist')),
      body: GridView.builder(
        itemCount: 30,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 0,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          // TODO: Fix the UI with Aspect Ratio
          // return FittedBox(child: ProductItem());
        },
      ),
    );
  }
}
