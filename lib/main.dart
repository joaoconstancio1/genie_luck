import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:genie_luck/core/app_routes.dart';
import 'package:genie_luck/core/app_initializer.dart.dart';
import 'package:genie_luck/core/design/theme.dart';
import 'package:genie_luck/l10n/generated/app_localizations.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInitializer.initializeDependencies();

  final appLinks = AppLinks();

  final sub = appLinks.uriLinkStream.listen((uri) {
    print('Received URI: $uri');
    final id = uri.queryParameters['id'];
    final valueCoin = uri.queryParameters['value_coin'];
    if (id != null && valueCoin != null) {
      AppRoutes.router.go('/payment-redirect?id=$id&value_coin=$valueCoin');
    }
  });

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
