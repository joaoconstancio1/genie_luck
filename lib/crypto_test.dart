import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genie_luck/core/design/gl_primary_button.dart';
import 'package:genie_luck/modules/payment/data/datasources/payment_datasource.dart';
import 'package:genie_luck/modules/payment/data/repositories/payment_repository.dart';
import 'package:get_it/get_it.dart';

class CryptoTest extends StatefulWidget {
  const CryptoTest({super.key});

  @override
  State<CryptoTest> createState() => _CryptoTestState();
}

class _CryptoTestState extends State<CryptoTest> {
  final PaymentRepository paymentRepository = GetIt.I<PaymentRepository>();
  final email = 'joaovitorconstancio@hotmail.com';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 60),
          GlPrimaryButton(
            text: 'Testar Todos',
            onPressed: () {
              paymentRepository.testAllProviders(amount: 30, email: email);
            },
          ),
          SizedBox(height: 60),
          GlPrimaryButton(
            text: 'Testar individual ',
            onPressed: () {
              paymentRepository.createPayment(
                provider: Providers.alchemypay,
                amount: 50,
                email: email,
              );
            },
          ),
          SizedBox(height: 60),
          GlPrimaryButton(
            text: 'Testar em ordem',
            onPressed: () {
              paymentRepository.openNextProvider(amount: 30, email: email);
            },
          ),
        ],
      ),
    );
  }
}
