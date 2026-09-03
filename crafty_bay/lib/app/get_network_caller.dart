import 'package:crafty_bay/app/providers/auth_controller.dart';
import 'package:crafty_bay/core/services/network_caller/network_caller.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

import 'crafty_bay_app.dart';

NetworkCaller getNetworkCaller() {
  return NetworkCaller(
    headers: () => {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (AuthController.accessToken != null) 'token': AuthController.accessToken!
    },
    onUnauthorize: () async {
      await AuthController.clearUserData();
      Navigator.pushNamed(
        CraftyBayApp.navigatorKey.currentContext!,
        SignInScreen.name,
      );
    }
  );
}
// UseCase
// getNetworkCaller().getRequest('https://jsonplaceholder.typicode.com/todos/1')