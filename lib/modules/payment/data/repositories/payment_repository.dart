import 'package:genie_luck/modules/payment/data/datasources/payment_datasource.dart';

class PaymentRepository {
  final PaymentDatasource datasource;

  PaymentRepository(this.datasource);

  Future<void> createPayment({required double amount, String? email}) async {
    final walletControl = await datasource.getWalletControl(
      address: '0x4F63BE8b203E9D5013AAafABE9e32AC78077551C',
      callback: 'https://www.genie-luck.com/payment-redirect',
    );

    await datasource.processPayment(
      encryptedAddress: walletControl['address_in'],
      amount: amount,
      provider: Providers.transak,
      email: email,
      currency: 'BRL',
    );
  }
}

class Providers {
  static const moonpay = 'moonpay';
  static const banxa = 'banxa';
  static const wert = 'wert';
  static const transak = 'transak';
  static const particle = 'particle';
  static const guardarian = 'guardarian';
  static const rampnetwork = 'rampnetwork';
  static const mercuryo = 'mercuryo';
  static const utorg = 'utorg';
  static const transfi = 'transfi';
  static const alchemypay = 'alchemypay';
  static const changenow = 'changenow';
  static const stripe = 'stripe';
  static const topper = 'topper';
  static const sardine = 'sardine';
  static const upi = 'upi';
  static const robinhood = 'robinhood';
  static const coinbase = 'coinbase';
  static const unlimit = 'unlimit';
  static const bitnovo = 'bitnovo';
  static const simpleswap = 'simpleswap';
  static const simplex = 'simplex';
  static const interac = 'interac';
  static const swipelux = 'swipelux';
  static const kado = 'kado';
  static const itez = 'itez';
}
