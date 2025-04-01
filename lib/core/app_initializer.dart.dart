import 'package:genie_luck/register/register_dependency_injection.dart';

class AppInitializer {
  static void initializeDependencies() {
    final registerDI = RegisterDependencyInjection();
    registerDI.setupDependencyInjection();
  }
}
