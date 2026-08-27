import 'package:crafty_bay/app/urls.dart';
import 'package:flutter/foundation.dart';

import '../../../../app/get_network_caller.dart';
import '../../models/product_model.dart';

class ProductListProvider extends ChangeNotifier {
  int _pageNo = 0;
  final int _pageSize = 20;
  int? _lastPage;
  bool _initialLoading = false;
  bool get initialLoading => _initialLoading;
  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  final List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> getProductList(String categoryId) async {
    _pageNo++;
    if (_lastPage != null && _pageNo > _lastPage!) {
      return;
    }

    if (_isInitialLoading) {
      _initialLoading = true;
    } else {
      _isLoadingMore = true;
    }
    notifyListeners();

    final response = await getNetworkCaller().getRequest(
      Urls.getProductListByCategoryUrl(categoryId, _pageNo, _pageSize),
    );

    if (response.isSuccess) {
      _lastPage ??= response.body['data']['last_page'];
      List<ProductModel> newProducts = [];
      for (var product in response.body['data']['results']) {
        newProducts.add(ProductModel.fromJson(product));
      }
      _products.addAll(newProducts);
    } else {
      _errorMessage = response.errorMessage;
    }

    if (_isInitialLoading) {
      _initialLoading = false;
    } else {
      _isLoadingMore = false;
    }
    notifyListeners();
  }

  bool get _isInitialLoading => _pageNo == 1;

  bool get isLoading => _initialLoading || _isLoadingMore;

  void refreshProductList(String categoryId) {
    _pageNo = 0;
    _lastPage = null;
    _products.clear();
    getProductList(categoryId);
  }
}
