import 'package:email_validator/email_validator.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (EmailValidator.validate(value ?? '') == false) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validateText(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message ?? 'Enter a valid value';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your phone number';
    }
    if (RegExp(r'^01[3-9]\d{8}$').hasMatch(value) == false) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null) {
      return 'Enter your password';
    } else if (value.length < 7) {
      return 'Enter a password more than 6 letters';
    }
    return null;
  }
}