import 'package:dio/dio.dart';
import 'package:genie_luck/core/http_client/custom_http_client.dart';
import 'package:genie_luck/core/http_client/dio_http_client.dart';
import 'package:genie_luck/modules/register/data/datasources/register_datasource.dart';
import 'package:genie_luck/modules/register/data/repositories/register_repository.dart';
import 'package:get_it/get_it.dart';

class RegisterDependencyInjection {
  final GetIt getIt = GetIt.instance;

  void setupDependencyInjection() {
    getIt.registerFactory<CustomHttpClient>(
      () => DioHttpClient(Dio(BaseOptions())),
    );

    getIt.registerSingleton<RegisterDatasource>(
      RegisterDatasource(getIt<CustomHttpClient>()),
    );

    getIt.registerSingleton<RegisterRepository>(
      RegisterRepository(getIt<RegisterDatasource>()),
    );
  }
}
