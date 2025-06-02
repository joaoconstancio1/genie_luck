import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:genie_luck/core/app_routes.dart';
import 'package:genie_luck/core/app_initializer.dart.dart';
import 'package:genie_luck/core/design/theme.dart';
import 'package:genie_luck/flavors/flavors.dart';
import 'package:genie_luck/l10n/generated/app_localizations.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInitializer.initializeDependencies();

  await Firebase.initializeApp(options: F.firebaseConfigOptions);

  runApp(
    MaterialApp.router(
      routerConfig: AppRoutes.router,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      //TODO: remove fixed theme
      themeMode: ThemeMode.light,
      locale: Locale('pt'), // Default locale
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    ),
  );
}
