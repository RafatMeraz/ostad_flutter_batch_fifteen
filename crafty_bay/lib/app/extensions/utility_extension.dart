import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

extension UtilityExtension on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;

  TextTheme get textTheme => TextTheme.of(this);
}