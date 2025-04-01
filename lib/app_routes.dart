// app_routes.dart
import 'package:flutter/material.dart';
import 'package:genie_luck/register/presenter/pages/register_page.dart';
import 'package:go_router/go_router.dart';
import 'genie_slider.dart';

class AppRoutes {
  // Defina os caminhos de forma estática para facilitar o uso
  static const String login = '/login';
  static const String genieSlider = '/genie-slider';
  static const String notFound = '/404';

  // Método para criar o GoRouter
  static GoRouter get router {
    return GoRouter(
      initialLocation: login, // Rota inicial
      routes: [
        GoRoute(path: login, builder: (context, state) => RegisterPage()),
        GoRoute(path: genieSlider, builder: (context, state) => GenieSlider()),
        // Rota padrão para páginas não encontradas
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
