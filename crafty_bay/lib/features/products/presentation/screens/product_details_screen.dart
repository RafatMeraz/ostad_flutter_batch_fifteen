import 'package:crafty_bay/app/providers/auth_controller.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:crafty_bay/features/cart/data/models/add_to_cart_params.dart';
import 'package:crafty_bay/features/cart/presentation/providers/add_to_cart_provider.dart';
import 'package:crafty_bay/features/products/presentation/providers/product_details_provider.dart';
import 'package:crafty_bay/features/products/presentation/widgets/product_details/color_picker.dart';
import 'package:crafty_bay/features/products/presentation/widgets/product_details/size_picker.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/centered_progress_indicator.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/inc_dec_button.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
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
  final AddToCartProvider _addToCartProvider = AddToCartProvider();

  String? _selectedColor;
  String? _selectedSize;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _productDetailsProvider.getProductDetails(widget.productId);
  }

  void _addToCart() async {
    if (await AuthController.isLoggedIn() == false) {
      Navigator.pushNamed(context, SignInScreen.name);
      return;
    }

    final bool result = await _addToCartProvider.addToCart(
      AddToCartParams(
        productId: widget.productId,
        color: _selectedColor ?? '',
        size: _selectedSize ?? '',
        quantity: _quantity,
      ),
    );

    if (!mounted) {
      return;
    }

    if (result) {
      showSnackBarMessage(context, 'Added to cart');
    } else {
      showSnackBarMessage(context, _addToCartProvider.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _productDetailsProvider),
        ChangeNotifierProvider.value(value: _addToCartProvider),
      ],
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
                        ProductImageCarousel(images: productDetails.photos),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      productDetails.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 80,
                                    child: IncDecButton(
                                      initialValue: 1,
                                      onChange: (int value) {
                                        _quantity = value;
                                      },
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
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    color: AppColors.themeColor,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(
                                        Icons.favorite_border,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Color',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ColorPicker(
                                colors: productDetails.colors,
                                onChange: (String selectedColor) {
                                  _selectedColor = selectedColor;
                                },
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Size',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizePicker(
                                sizes: productDetails.sizes,
                                onChange: (String selectedSize) {
                                  _selectedSize = selectedSize;
                                },
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Description',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                productDetails.description,
                                style: const TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PriceAndAddToCartSection(onAddToCart: _addToCart),
              ],
            );
          },
        ),
      ),
    );
  }
}
