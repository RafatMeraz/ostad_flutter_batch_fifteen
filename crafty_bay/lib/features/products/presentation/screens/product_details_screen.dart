import 'package:crafty_bay/features/products/presentation/widgets/product_details/color_picker.dart';
import 'package:crafty_bay/features/products/presentation/widgets/product_details/size_picker.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/inc_dec_button.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../widgets/product_details/price_and_add_to_cart_section.dart';
import '../widgets/product_details/product_image_carousel.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  static const String name = '/product-details';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProductImageCarousel(),
                  Padding(
                    padding: const .all(16),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Addidas new shoe 2021 - AK2323KF',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: .w600,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: IncDecButton(
                                initialValue: 1,
                                onChange: (int value) {},
                                maxValue: 10,
                                minValue: 1,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Wrap(
                              spacing: 8,
                              children: [
                                Icon(Icons.star, size: 20, color: Colors.amber),
                                Text('4.5'),
                              ],
                            ),
                            SizedBox(width: 8),
                            TextButton(
                              onPressed: () {},
                              child: Text('Reviews'),
                            ),
                            SizedBox(width: 8),
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
                        SizedBox(height: 16),
                        Text(
                          'Color',
                          style: TextStyle(
                            fontWeight: .w600,
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        ColorPicker(
                          colors: ['Red', 'Black', 'Pink', 'White'],
                          onChange: (String selectedColor) {},
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Size',
                          style: TextStyle(
                            fontWeight: .w600,
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        SizePicker(
                          sizes: ['Small', 'Medium', 'Large', 'Extra Large'],
                          onChange: (String selectedSize) {
                            debugPrint(selectedSize);
                          },
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Color',
                          style: TextStyle(
                            fontWeight: .w600,
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London''',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          PriceAndAddToCartSection(),
        ],
      ),
    );
  }
}
