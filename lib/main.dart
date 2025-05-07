import 'dart:async';

import 'package:flutter/material.dart';
import 'package:genie_luck/app_routes.dart';
import 'package:genie_luck/core/app_initializer.dart.dart';
import 'package:genie_luck/core/design/theme.dart';
import 'package:genie_luck/l10n/generated/app_localizations.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInitializer.initializeDependencies();

  runApp(
    MaterialApp.router(
      routerConfig: AppRoutes.router,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      //TODO: remove fixed theme
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      locale: Locale('pt'), // Default locale
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    ),
  );
}
