import 'package:flutter/foundation.dart';

class MainNavHolderProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void backToHome() {
    changeIndex(0);
  }

  void moveToCategory() {
    changeIndex(1);
  }
}