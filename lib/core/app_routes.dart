import 'package:flutter/material.dart';
import 'package:genie_luck/crypto_test.dart';
import 'package:genie_luck/modules/genie_slider/presenter/pages/genie_slider.dart';
import 'package:genie_luck/modules/login/presenter/pages/login_page.dart';
import 'package:genie_luck/modules/register/presenter/pages/register_page.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String register = '/register';
  static const String login = '/login';
  static const String genieSlider = '/genie-slider';

  static GoRouter get router {
    return GoRouter(
      initialLocation: register,
      routes: [
        GoRoute(
          path: '/payment-redirect',
          name: 'paymentRedirect',
          builder: (context, state) {
            final id = state.uri.queryParameters['id'];
            final value_coin = state.uri.queryParameters['value_coin'];
            return Scaffold(
              appBar: AppBar(title: Text('Payment Redirect')),
              body: Center(
                child: Text(
                  'Payment callback received. ID: $id, Value Coin: $value_coin',
                ),
              ),
            );
          },
        ),
        GoRoute(
          path: register,
          name: 'register',
          builder: (context, state) => CryptoTest(),
        ),
        GoRoute(
          path: login,
          name: 'login',
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          path: genieSlider,
          name: 'genieSlider',
          builder: (context, state) => GenieSlider(),
        ),
      ],
      errorBuilder: (context, state) {
        return Scaffold(body: Center(child: Text('Página não encontrada')));
      },
    );
  }
}
