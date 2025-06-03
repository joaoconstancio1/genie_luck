import 'package:genie_luck/core/http_client/custom_http_client.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentDatasource {
  final CustomHttpClient client;

  PaymentDatasource(this.client);

  Future<Map<String, dynamic>> getWalletControl({
    required String address,
    required String callback,
  }) async {
    final response = await client.get(
      'https://api.card2crypto.org/control/wallet.php?',
      queryParameters: {'address': address, 'callback': callback},
    );

    try {
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Erro ao buscar controle da carteira $e');
    }
  }

  Future<void> processPayment({
    required String encryptedAddress,
    required double amount,
    required String provider,
    String? email,
    required String currency,
  }) async {
    final uri = Uri.parse(
      'https://pay.card2crypto.org/process-payment.php?'
      'address=$encryptedAddress&'
      'amount=$amount&'
      'provider=$provider&'
      'email=$email&'
      'currency=$currency',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Não foi possível abrir a URL de pagamento');
    }
  }
}
