import 'package:crafty_bay/app/urls.dart';
import 'package:flutter/foundation.dart';

import '../../../../app/get_network_caller.dart';
import '../../data/category_model.dart';

class CategoryListProvider extends ChangeNotifier {
  int _pageNo = 0;

  final int _pageSize = 30;

  int? _lastPage;

  bool _initialLoading = false;

  bool get initialLoading => _initialLoading;

  bool _isLoadingMore = false;

  bool get isLoadingMore => _isLoadingMore;

  final List<CategoryModel> _categories = [];

  List<CategoryModel> get categories => _categories;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> getCategoryList() async {
    _pageNo++;
    if ((_lastPage == null || _pageNo <= _lastPage!) == false) {
      return;
    }

    if (_isInitialLoading) {
      _initialLoading = true;
    } else {
      _isLoadingMore = true;
    }
    notifyListeners();

    final response = await getNetworkCaller().getRequest(
      Urls.getCategoryListUrl(_pageNo, _pageSize),
    );
    if (response.isSuccess) {
      // if (_lastPage == null) {
      //   _lastPage = response.body['data']['last_page'];
      // }
      _lastPage ??= response.body['data']['last_page'];
      List<CategoryModel> newCategories = [];
      for (var category in response.body['data']['results']) {
        newCategories.add(CategoryModel.fromJson(category));
      }
      _categories.addAll(newCategories);
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

  void refreshCategoryList() {
    _pageNo = 0;
    _categories.clear();
    getCategoryList();
  }
}
