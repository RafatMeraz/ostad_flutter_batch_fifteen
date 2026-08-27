import 'package:crafty_bay/features/products/presentation/providers/product_details_provider.dart';
import 'package:crafty_bay/features/products/presentation/providers/product_list_provider.dart';
import 'package:crafty_bay/features/products/presentation/widgets/product_details/color_picker.dart';
import 'package:crafty_bay/features/products/presentation/widgets/product_details/size_picker.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/centered_progress_indicator.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/inc_dec_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../widgets/product_details/price_and_add_to_cart_section.dart';
import '../widgets/product_details/product_image_carousel.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  static const String name = '/product-details';

  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsProvider _productDetailsProvider =
      ProductDetailsProvider();

  @override
  void initState() {
    super.initState();
    _productDetailsProvider.getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _productDetailsProvider,
      child: Scaffold(
        appBar: AppBar(title: Text('Product Details')),
        body: Consumer<ProductDetailsProvider>(
          builder: (context, _, _) {
            if (_productDetailsProvider.isLoading) {
              return CenteredProgressIndicator();
            } else if (_productDetailsProvider.errorMessage != null) {
              return Center(child: Text(_productDetailsProvider.errorMessage!));
            }

            final productDetails = _productDetailsProvider.productDetails!;
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ProductImageCarousel(
                          images: productDetails.photos,
                        ),
                        Padding(
                          padding: const .all(16),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      productDetails.title,
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
                                      maxValue: productDetails.quantity,
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
                                      Icon(
                                        Icons.star,
                                        size: 20,
                                        color: Colors.amber,
                                      ),
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
                                colors: productDetails.colors,
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
                                sizes: productDetails.sizes,
                                onChange: (String selectedSize) {
                                  debugPrint(selectedSize);
                                },
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontWeight: .w600,
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                productDetails.description,
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
            );
          },
        ),
      ),
    );
  }
}
