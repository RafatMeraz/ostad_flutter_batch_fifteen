import 'package:flutter/foundation.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoginInProgress = false;

  bool get isLoginInProgress => _isLoginInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;

    _isLoginInProgress = true;
    notifyListeners();

    Map<String, dynamic> requestBody = {"email": email, "password": password};

    final ApiResponse response = await ApiCaller.postRequest(
      URL: Urls.login,
      body: requestBody,
    );

    if (response.isSuccess) {
      UserModel model = UserModel.fromJson(response.responseData['data']);
      String accessToken = response.responseData['token'];

      await AuthController.saveUserData(model, accessToken);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _isLoginInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
