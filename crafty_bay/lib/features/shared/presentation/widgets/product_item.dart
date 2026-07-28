import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/asset_paths.dart';
import '../../../../app/constants.dart';
import '../../../products/presentation/screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsScreen.name);
      },
      child: SizedBox(
        width: 140,
        child: Card(
          color: Colors.white,
          shadowColor: AppColors.themeColor.withAlpha(30),
          elevation: 3,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Container(
                width: 140,
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withAlpha(20),
                  borderRadius: .only(
                    topLeft: .circular(8),
                    topRight: .circular(8),
                  ),
                ),
                child: Padding(
                  padding: const .all(8),
                  child: Image.asset(
                    AssetPaths.dummyImagePng,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      'Title of productwek rlewrjlk',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: .w500,
                        color: Colors.black54,
                        overflow: .ellipsis,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text(
                          '${Constants.takaSign}100',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: .w500,
                            color: AppColors.themeColor,
                          ),
                        ),
                        Wrap(
                          children: [
                            Icon(Icons.star, size: 20, color: Colors.amber),
                            Text('4.5'),
                          ],
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: .circular(4),
                          ),
                          color: AppColors.themeColor,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.favorite_border,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
