import 'package:genie_luck/core/core_injector.dart';
import 'package:genie_luck/modules/login/login_injector.dart';
import 'package:genie_luck/modules/payment/payment_injector.dart';
import 'package:genie_luck/modules/register/register_injector.dart';

class AppInitializer {
  static Future<void> initializeDependencies() async {
    final coreDI = CoreInjector();
    coreDI.setupDependencyInjection();

    final registerDI = RegisterInjector();
    registerDI.setupDependencyInjection();

    final loginDI = LoginInjector();
    loginDI.setupDependencyInjection();

    final paymentInjector = PaymentInjector();
    paymentInjector.setupDependencyInjection();
  }
}
