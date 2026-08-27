import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../products/models/product_model.dart';
import '../../../products/presentation/screens/product_details_screen.dart';
import 'no_image.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailsScreen.name,
          arguments: productModel.id,
        );
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
                  child: CachedNetworkImage(
                    width: 140,
                    imageUrl: _getPhotoPath(productModel.photos),
                    fit: BoxFit.scaleDown,
                    errorWidget: (_, _, _) => NoImage(),
                    progressIndicatorBuilder: (_, _, _) => NoImage(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      productModel.title,
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
                          '${Constants.takaSign}${productModel.currentPrice}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: .w500,
                            color: AppColors.themeColor,
                          ),
                        ),
                        Wrap(
                          children: [
                            Icon(Icons.star, size: 20, color: Colors.amber),
                            Text('${productModel.rating}'),
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

  String _getPhotoPath(List<String> photos) {
    return photos.length > 0 ? photos.first : '';
  }
}
