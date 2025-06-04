import 'package:genie_luck/modules/payment/data/datasources/payment_datasource.dart';

class PaymentRepository {
  final PaymentDatasource datasource;

  PaymentRepository(this.datasource);

  Future<void> createPayment({
    required double amount,
    String? email,
    required String provider,
  }) async {
    final walletControl = await datasource.getWalletControl(
      address: '0x4F63BE8b203E9D5013AAafABE9e32AC78077551C',
      callback: 'https://www.genie-luck.com/payment-redirect',
    );

    await datasource.processPayment(
      encryptedAddress: walletControl['address_in'],
      amount: amount,
      provider: provider,
      email: email,
      currency: 'BRL',
    );
  }

  int _currentIndex = 0;

  final List<String> _providers = [
    Providers.moonpay,
    Providers.banxa,
    Providers.wert,
    Providers.transak,
    Providers.particle,
    Providers.guardarian,
    Providers.rampnetwork,
    Providers.mercuryo,
    Providers.utorg,
    Providers.transfi,
    Providers.alchemypay,
    Providers.changenow,
    Providers.stripe,
    Providers.topper,
    Providers.sardine,
    Providers.upi,
    Providers.robinhood,
    Providers.coinbase,
    Providers.unlimit,
    Providers.bitnovo,
    Providers.simpleswap,
    Providers.simplex,
    Providers.interac,
    Providers.swipelux,
    Providers.kado,
    Providers.itez,
  ];

  Future<void> openNextProvider({required double amount, String? email}) async {
    if (_currentIndex >= _providers.length) {
      print('✅ Todos os providers foram testados.');
      return;
    }

    final provider = _providers[_currentIndex++];
    print('🔄 Abrindo $provider...');
    await createPayment(amount: amount, email: email, provider: provider);
  }

  Future<void> testAllProviders({required double amount, String? email}) async {
    final providers = [
      Providers.moonpay,
      Providers.banxa,
      Providers.wert,
      Providers.transak,
      Providers.particle,
      Providers.guardarian,
      Providers.rampnetwork,
      Providers.mercuryo,
      Providers.utorg,
      Providers.transfi,
      Providers.alchemypay,
      Providers.changenow,
      Providers.stripe,
      Providers.topper,
      Providers.sardine,
      Providers.upi,
      Providers.robinhood,
      Providers.coinbase,
      Providers.unlimit,
      Providers.bitnovo,
      Providers.simpleswap,
      Providers.simplex,
      Providers.interac,
      Providers.swipelux,
      Providers.kado,
      Providers.itez,
    ];

    for (final provider in providers) {
      try {
        print('🔄 Testing $provider...');
        await createPayment(amount: amount, email: email, provider: provider);
        print('✅ $provider processed successfully.\n');
      } catch (e) {
        print('❌ $provider failed: $e\n');
      }
    }
  }
}

class Providers {
  static const moonpay = 'moonpay'; // min R$130
  static const banxa = 'banxa';
  static const wert = 'wert';
  static const transak = 'transak';
  static const particle = 'particle';
  static const guardarian = 'guardarian';
  static const rampnetwork =
      'rampnetwork'; //bom? minimo 40 reais taxa alto para pouco valor
  static const mercuryo = 'mercuryo'; //testar com pelo menos 70 reais
  static const utorg = 'utorg';
  static const transfi = 'transfi';
  static const alchemypay = 'alchemypay'; //bom? está em ingles, aceita PIX
  static const changenow = 'changenow';
  static const stripe = 'stripe'; //testar com USD
  static const topper =
      'topper'; // minimo R$60, taxa baixa e em PT, precisa enviar documento para pagar
  static const sardine = 'sardine';
  static const upi = 'upi';
  static const robinhood = 'robinhood';
  static const coinbase = 'coinbase'; // preciso de numero para testar
  static const unlimit = 'unlimit';
  static const bitnovo = 'bitnovo';
  static const simpleswap = 'simpleswap';
  static const simplex = 'simplex';
  static const interac = 'interac';
  static const swipelux = 'swipelux';
  static const kado = 'kado';
  static const itez = 'itez';
}
