import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/asset_paths.dart';
import '../../../../app/constants.dart';
import '../../../shared/presentation/widgets/inc_dec_button.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: .symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      shadowColor: AppColors.themeColor.withAlpha(50),
      elevation: 2,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetPaths.dummyImagePng, width: 100),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              'Title of the product',
                              style: TextStyle(
                                fontWeight: .w600,
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            Text('Size: XL  Color: Red'),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        '${Constants.takaSign}100',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: .w600,
                          color: AppColors.themeColor,
                        ),
                      ),
                      SizedBox(
                        width: 90,
                        child: IncDecButton(
                          initialValue: 1,
                          onChange: (int value) {},
                          maxValue: 10,
                          minValue: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
