// app_routes.dart
import 'package:flutter/material.dart';
import 'package:genie_luck/modules/genie_slider/presenter/pages/genie_slider.dart';
import 'package:genie_luck/modules/login/presenter/pages/login_page.dart';
import 'package:genie_luck/modules/register/presenter/pages/register_page.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String register = '/register';
  static const String login = '/login';
  static const String genieSlider = '/genie-slider';
  static const String notFound = '/404';

  static GoRouter get router {
    return GoRouter(
      initialLocation: login,
      routes: [
        GoRoute(path: register, builder: (context, state) => RegisterPage()),
        GoRoute(path: login, builder: (context, state) => LoginPage()),
        GoRoute(path: genieSlider, builder: (context, state) => GenieSlider()),
        GoRoute(
          path: notFound,
          builder:
              (context, state) => Scaffold(
                body: Center(child: Text('Rota inválida: ${state.uri}')),
              ),
        ),
      ],
      errorBuilder: (context, state) {
        return Scaffold(body: Center(child: Text('Página não encontrada')));
      },
    );
  }
}
