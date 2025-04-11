import 'package:dio/dio.dart';
import 'package:genie_luck/core/http_client/custom_http_client.dart';
import 'package:genie_luck/core/http_client/dio_http_client.dart';
import 'package:get_it/get_it.dart';

class CoreInjector {
  final GetIt getIt = GetIt.instance;

  void setupDependencyInjection() {
    getIt.registerFactory<CustomHttpClient>(
      () => DioHttpClient(Dio(BaseOptions())),
    );
  }
}
