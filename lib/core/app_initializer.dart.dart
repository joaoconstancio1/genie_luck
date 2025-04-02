import 'package:genie_luck/modules/register/register_dependency_injection.dart';

class AppInitializer {
  static Future<void> initializeDependencies() async {
    final registerDI = RegisterDependencyInjection();
    registerDI.setupDependencyInjection();
  }
}
