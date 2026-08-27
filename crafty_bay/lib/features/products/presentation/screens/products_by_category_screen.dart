import 'package:crafty_bay/features/products/presentation/providers/product_list_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/centered_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../category/data/category_model.dart';
import '../../../shared/presentation/widgets/product_item.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  const ProductsByCategoryScreen({super.key, required this.category});

  static const String name = '/products-by-category';

  final CategoryModel category;

  @override
  State<ProductsByCategoryScreen> createState() =>
      _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  final ProductListProvider _productListProvider = ProductListProvider();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _productListProvider.getProductList(widget.category.id);
    _scrollController.addListener(_loadMore);
  }

  void _loadMore() {
    if (_productListProvider.isLoading == false &&
        _scrollController.position.extentBefore < 300) {
      _productListProvider.getProductList(widget.category.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _productListProvider,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.category.title)),
        body: Consumer<ProductListProvider>(
          builder: (context, _, _) {
            if (_productListProvider.initialLoading) {
              return CenteredProgressIndicator();
            }

            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    itemCount: _productListProvider.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      return FittedBox(child: ProductItem(
                        productModel: _productListProvider.products[index],
                      ));
                    },
                  ),
                ),
                if (_productListProvider.isLoadingMore)
                  LinearProgressIndicator()
              ],
            );
          }
        ),
      ),
    );
  }
}
