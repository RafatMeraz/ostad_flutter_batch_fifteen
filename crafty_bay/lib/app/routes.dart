import 'package:flutter/material.dart';

import '../features/auth/presentation/screens/sign_in_screen.dart';
import '../features/auth/presentation/screens/sign_up_screen.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/verify_otp_screen.dart';
import '../features/category/data/category_model.dart';
import '../features/products/presentation/screens/product_details_screen.dart';
import '../features/products/presentation/screens/products_by_category_screen.dart';
import '../features/shared/presentation/screens/main_nav_holder_screen.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    late Widget widget;

    switch (settings.name) {
      case SplashScreen.name:
        widget = SplashScreen();
      case SignUpScreen.name:
        widget = SignUpScreen();
      case VerifyOtpScreen.name:
        final email = settings.arguments as String;
        widget = VerifyOtpScreen(email: email);
      case SignInScreen.name:
        widget = SignInScreen();
      case MainNavHolderScreen.name:
          widget = MainNavHolderScreen();
      case ProductDetailsScreen.name:
          widget = ProductDetailsScreen();
      case ProductsByCategoryScreen.name:
        final category = settings.arguments as CategoryModel;
        widget = ProductsByCategoryScreen(category: category);
    }

    return MaterialPageRoute(builder: (_) => widget);
  }
}
