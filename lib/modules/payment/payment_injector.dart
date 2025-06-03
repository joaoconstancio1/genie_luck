import 'package:genie_luck/core/http_client/custom_http_client.dart';
import 'package:genie_luck/modules/payment/data/datasources/payment_datasource.dart';
import 'package:genie_luck/modules/payment/data/repositories/payment_repository.dart';
import 'package:get_it/get_it.dart';

class PaymentInjector {
  final GetIt getIt = GetIt.instance;

  void setupDependencyInjection() {
    getIt.registerSingleton<PaymentDatasource>(
      PaymentDatasource(getIt<CustomHttpClient>()),
    );

    getIt.registerSingleton<PaymentRepository>(
      PaymentRepository(getIt<PaymentDatasource>()),
    );
  }
}
