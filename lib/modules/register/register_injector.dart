import 'package:genie_luck/core/http_client/custom_http_client.dart';
import 'package:genie_luck/modules/register/data/datasources/register_datasource.dart';
import 'package:genie_luck/modules/register/data/repositories/register_repository.dart';
import 'package:genie_luck/modules/register/presenter/cubit/register_cubit.dart';
import 'package:get_it/get_it.dart';

class RegisterInjector {
  final GetIt getIt = GetIt.instance;

  void setupDependencyInjection() {
    getIt.registerSingleton<RegisterDatasource>(
      RegisterDatasource(getIt<CustomHttpClient>()),
    );

    getIt.registerSingleton<RegisterRepository>(
      RegisterRepository(getIt<RegisterDatasource>()),
    );
    getIt.registerSingleton<RegisterCubit>(
      RegisterCubit(repository: getIt<RegisterRepository>()),
    );
  }
}
