import 'package:flutter/material.dart';
import 'package:genie_luck/app_routes.dart';
import 'package:genie_luck/core/app_initializer.dart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInitializer.initializeDependencies();

  runApp(
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.router,
    ),
  );
}
