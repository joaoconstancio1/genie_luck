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
  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController(
      text: '30',
    );
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor',
                border: OutlineInputBorder(),
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          GlPrimaryButton(
            text: 'Teste',
            onPressed: () {
              paymentRepository.createPayment(
                amount: double.tryParse(amountController.text) ?? 0.0,
                email: 'genieluck26@gmail.com',
              );
            },
          ),
        ],
      ),
    );
  }
}
