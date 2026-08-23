import 'package:flutter/foundation.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/urls.dart';
import '../../data/models/slider_model.dart';

class HomeSlidersProvider extends ChangeNotifier {
  bool _getHomeSlidersInProgress = false;

  bool get getHomeSlidersInProgress => _getHomeSlidersInProgress;

  List<SliderModel> _sliders = [];

  List<SliderModel> get sliders => _sliders;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getHomeSliders() async {
    bool isSuccess = false;

    _getHomeSlidersInProgress = true;
    notifyListeners();

    final response = await getNetworkCaller().getRequest(Urls.homeSlidersUrl);
    if (response.isSuccess) {
      // _sliders = (response.body['data']['results'])
      //     .map((e) => SliderModel.fromJson(e))
      //     .toList();

      List<SliderModel> list = [];
      for (var element in response.body['data']['results']) {
        list.add(SliderModel.fromJson(element));
      }
      _sliders = list;

      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getHomeSlidersInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}