import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/features/cart/data/models/add_to_cart_params.dart';
import 'package:flutter/foundation.dart';
import '../../../../app/get_network_caller.dart';

class AddToCartProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> addToCart(AddToCartParams params) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await getNetworkCaller().postRequest(
      Urls.addToCartUrl,
      body: params.toJson(),
    );

    _isLoading = false;
    if (response.isSuccess) {
      notifyListeners();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      notifyListeners();
      return false;
    }
  }
}
