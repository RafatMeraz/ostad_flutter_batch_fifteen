import 'package:crafty_bay/app/providers/theme_provider.dart';
import 'package:crafty_bay/features/shared/presentation/providers/main_nav_holder_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../features/auth/presentation/screens/splash_screen.dart';
import '../l10n/app_localizations.dart';
import 'app_theme.dart';
import 'providers/locale_provider.dart';
import 'routes.dart';

class CraftyBayApp extends StatefulWidget {
  const CraftyBayApp({super.key});

  @override
  State<CraftyBayApp> createState() => _CraftyBayAppState();
}

class _CraftyBayAppState extends State<CraftyBayApp> {
  final LocaleProvider _localeProvider = LocaleProvider();
  final ThemeProvider _themeProvider = ThemeProvider();

  @override
  void initState() {
    super.initState();
    _themeProvider.init();
    _localeProvider.init();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _localeProvider),
        ChangeNotifierProvider.value(value: _themeProvider),
        ChangeNotifierProvider(create: (_) => MainNavHolderProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, _, _) {
          return Consumer<LocaleProvider>(
            builder: (context, _, _) {
              return MaterialApp(
                title: 'Crafty Bay',
                initialRoute: SplashScreen.name,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                onGenerateRoute: AppRoutes.onGenerateRoute,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: _themeProvider.currentThemeMode,
                supportedLocales: _localeProvider.supportedLocales,
                locale: _localeProvider.currentLocale,
              );
            }
          );
        }
      ),
    );
  }
}
