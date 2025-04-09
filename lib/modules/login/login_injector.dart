import 'package:genie_luck/core/http_client/custom_http_client.dart';
import 'package:genie_luck/modules/login/data/datasources/login_datasource.dart';
import 'package:genie_luck/modules/login/data/repositories/login_repository.dart';
import 'package:get_it/get_it.dart';

class LoginInjector {
  final GetIt getIt = GetIt.instance;

  void setupDependencyInjection() {
    getIt.registerSingleton<LoginDatasource>(
      LoginDatasource(getIt<CustomHttpClient>()),
    );

    getIt.registerSingleton<LoginRepository>(
      LoginRepository(getIt<LoginDatasource>()),
    );
  }
}
