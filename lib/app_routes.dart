import 'package:flutter/material.dart';
import 'package:genie_luck/genie_slider.dart';
import 'package:genie_luck/login/pages/login_page.dart';

class AppRoutes {
  static const String login = '/';
  static const String genieSlider = '/genie-slider';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case genieSlider:
        return MaterialPageRoute(builder: (_) => GenieSlider());
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('Rota não encontrada: ${settings.name}'),
                ),
              ),
        );
    }
  }
}
