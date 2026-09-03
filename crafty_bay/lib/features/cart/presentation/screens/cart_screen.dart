import 'package:crafty_bay/features/cart/presentation/providers/cart_list_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/centered_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/providers/main_nav_holder_provider.dart';
import '../widgets/cart_item.dart';
import '../widgets/price_and_checkout_section.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartListProvider _cartListProvider = CartListProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cartListProvider.getCartList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, _) => _backToHome(),
      child: ChangeNotifierProvider.value(
        value: _cartListProvider,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Cart'),
            leading: IconButton(
              onPressed: () => _backToHome(),
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          body: Consumer<CartListProvider>(
            builder: (context, _, _) {
              if (_cartListProvider.isLoading) {
                return CenteredProgressIndicator();
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _cartListProvider.cartList.length,
                      itemBuilder: (context, index) {
                        return CartItem(
                          cartModel: _cartListProvider.cartList[index],
                        );
                      },
                    ),
                  ),
                  PriceAndCheckoutSection(),
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  void _backToHome() {
    context.read<MainNavHolderProvider>().backToHome();
  }
}