import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../app/app_colors.dart';
import '../../../../../app/constants.dart';
import '../../providers/product_details_provider.dart';

class PriceAndAddToCartSection extends StatelessWidget {
  const PriceAndAddToCartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.themeColor.withAlpha(30),
        borderRadius: .only(topLeft: .circular(16), topRight: .circular(16)),
      ),
      padding: .all(16),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              Text('Price', style: TextStyle(fontWeight: .w600)),
              Consumer<ProductDetailsProvider>(
                builder: (context, productDetailsProvider, _) {
                  return Text(
                    '${Constants.takaSign}${productDetailsProvider.productDetails!.currentPrice}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: .w600,
                      color: AppColors.themeColor,
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: FilledButton(onPressed: () {}, child: Text('Add to Cart')),
          ),
        ],
      ),
    );
  }
}
