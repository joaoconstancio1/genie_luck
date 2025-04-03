import 'package:flutter/material.dart';
import 'package:genie_luck/app_routes.dart';
import 'package:genie_luck/core/app_initializer.dart.dart';
import 'package:genie_luck/l10n/generated/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInitializer.initializeDependencies();

  runApp(
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.router,
      // locale: Locale('pt'), // Default locale
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    ),
  );
}
