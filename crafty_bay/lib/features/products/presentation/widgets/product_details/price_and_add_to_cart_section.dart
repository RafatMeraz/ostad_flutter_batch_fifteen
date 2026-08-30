import 'package:crafty_bay/features/cart/presentation/providers/add_to_cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../app/app_colors.dart';
import '../../../../../app/constants.dart';
import '../../providers/product_details_provider.dart';

class PriceAndAddToCartSection extends StatelessWidget {
  const PriceAndAddToCartSection({super.key, required this.onAddToCart});

  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.themeColor.withAlpha(30),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Price', style: TextStyle(fontWeight: FontWeight.w600)),
              Consumer<ProductDetailsProvider>(
                builder: (context, productDetailsProvider, _) {
                  return Text(
                    '${Constants.takaSign}${productDetailsProvider.productDetails!.currentPrice}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.themeColor,
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child: Consumer<AddToCartProvider>(
              builder: (context, addToCartProvider, _) {
                if (addToCartProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return FilledButton(
                  onPressed: onAddToCart,
                  child: const Text('Add to Cart'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
