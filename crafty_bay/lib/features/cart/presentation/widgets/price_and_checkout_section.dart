import 'package:flutter/material.dart';

import '../../../../../app/app_colors.dart';
import '../../../../../app/constants.dart';

class PriceAndCheckoutSection extends StatelessWidget {
  const PriceAndCheckoutSection({super.key});

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
              Text('Total Price', style: TextStyle(fontWeight: .w600)),
              Text(
                '${Constants.takaSign}1000',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: .w600,
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: FilledButton(onPressed: () {}, child: Text('Checkout')),
          ),
        ],
      ),
    );
  }
}
