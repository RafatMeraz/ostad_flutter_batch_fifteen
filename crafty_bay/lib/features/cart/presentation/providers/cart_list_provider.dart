import 'package:flutter/foundation.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/urls.dart';
import '../../data/models/cart_model.dart';

class CartListProvider extends ChangeNotifier {
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  List<CartModel> _cartList = [];

  List<CartModel> get cartList => _cartList;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getCartList() async {
    bool isSuccess = false;
    _isLoading = true;
    notifyListeners();

    final response = await getNetworkCaller().getRequest(Urls.cartListUrl);
    if (response.isSuccess) {
      // _cartList = (response.body['data'] as List)
      //     .map((e) => CartModel.fromJson(e))
      //     .toList();

      List<CartModel> cartList = [];
      for (var element in response.body['data']['results']) {
        cartList.add(CartModel.fromJson(element));
      }
      _cartList = cartList;

      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _isLoading = false;
    notifyListeners();

    return isSuccess;
  }

  double totalPrice() {
    double total = 0;
    for (var element in _cartList) {
      total += element.product.currentPrice * element.quantity;
    }
    return total;
  }

  void increaseProductQuantity(String productId, int quantity) {
    for (var element in _cartList) {
      if (element.product.id == productId) {
        element.quantity = quantity;
        break;
      }
    }
    notifyListeners();
  }
}