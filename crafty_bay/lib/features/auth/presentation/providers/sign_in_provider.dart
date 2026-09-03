import 'package:crafty_bay/app/providers/auth_controller.dart';
import 'package:crafty_bay/features/auth/data/models/sign_in_params.dart';
import 'package:crafty_bay/features/auth/data/models/user_model.dart';
import 'package:flutter/foundation.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/urls.dart';

class SignInProvider extends ChangeNotifier {
  bool _signInInProgress = false;

  bool get signInInProgress => _signInInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> signIn(SignInParams params) async {
    bool isSuccess = false;
    _signInInProgress = true;
    notifyListeners();

    final response = await getNetworkCaller().postRequest(
      Urls.signInUrl,
      body: params.toJson(),
      fromLogin: true,
    );
    if (response.isSuccess) {
      String token = response.body['data']['token'];
      UserModel userModel = UserModel.fromJson(response.body['data']['user']);

      await AuthController.saveUserData(token, userModel);

      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _signInInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}