import 'package:flutter/material.dart';
import 'package:genie_luck/app_routes.dart';

void main() {
  runApp(
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.router,
    ),
  );
}
