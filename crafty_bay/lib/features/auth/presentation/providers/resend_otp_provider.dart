import 'dart:async';

import 'package:flutter/foundation.dart';

class ResendOtpProvider extends ChangeNotifier {
  int _resendOtpTimer = 20;

  int get resendOtpTimer => _resendOtpTimer;

  bool get isTimerRunning => _timer != null;

  Timer? _timer;

  Future<void> startResendOtpTimer() async {
    _timer = null;
    _resendOtpTimer = 20;

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_resendOtpTimer > 0) {
        _resendOtpTimer--;
        notifyListeners();
      } else {
        _timer?.cancel();
        _timer = null;
        notifyListeners();
      }
    });
  }

  Future<void> stopResendOtpTimer() async {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
