import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty_bay/features/cart/data/models/cart_model.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/no_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../shared/presentation/widgets/inc_dec_button.dart';
import '../providers/cart_list_provider.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cartModel});

  final CartModel cartModel;

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
            child: CachedNetworkImage(
              imageUrl: _getImageUrl(cartModel.product.photos),
              width: 100,
              height: 100,
              errorWidget: (_, _, _) => NoImage(),
            ),
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
                              cartModel.product.title,
                              style: TextStyle(
                                fontWeight: .w600,
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              'Size: ${cartModel.size}  Color: ${cartModel.color}',
                            ),
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
                        '${Constants.takaSign}${cartModel.product.currentPrice}',
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
                          onChange: (int value) {
                            context
                                .read<CartListProvider>()
                                .increaseProductQuantity(
                                  cartModel.product.id,
                                  value,
                                );
                          },
                          maxValue: cartModel.product.quantity,
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

  String _getImageUrl(List<String> urls) {
    return urls.isNotEmpty ? urls.first : '';
  }
}
