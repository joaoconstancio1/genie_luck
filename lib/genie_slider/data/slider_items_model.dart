import 'package:flutter/material.dart';

class SliderItemModel {
  int? index;
  String? image;
  String? title;
  String? description;
  Color? color;
  double? minRange; // Valor mínimo do intervalo
  double? maxRange; // Valor máximo do intervalo
  double? value; // Valor do item
  double probability; // Probabilidade em %

  SliderItemModel({
    this.index,
    this.image,
    this.title,
    this.description,
    this.color,
    this.value,
    required this.probability,
  });

  static List<SliderItemModel> generateItems() {
    List<SliderItemModel> items = [
      SliderItemModel(
        title: 'R\$ 0,50',
        value: 0.50,
        image: 'assets/images/money.png',
        probability: 19.133,
      ),
      SliderItemModel(
        title: 'R\$ 0,75',
        value: 0.75,
        image: 'assets/images/money.png',
        probability: 17.133,
      ),
      SliderItemModel(
        title: 'R\$ 1,25',
        value: 1.25,
        image: 'assets/images/money.png',
        probability: 12.143,
      ),
      SliderItemModel(
        title: 'R\$ 1,50',
        value: 1.50,
        image: 'assets/images/money.png',
        probability: 14.733,
      ),
      SliderItemModel(
        title: 'R\$ 1,75',
        image: 'assets/images/money.png',
        value: 1.75,
        probability: 14.453,
      ),
      SliderItemModel(
        title: 'R\$ 2,00',
        image: 'assets/images/money.png',
        value: 2.00,
        probability: 14.487,
      ),
      SliderItemModel(
        title: 'iPhone 16 (R\$ 5.200)',
        image: 'assets/images/iphone16.png',
        value: 5200,
        probability: 0.015,
      ),
      SliderItemModel(
        title: 'PlayStation 5 (R\$ 3.200)',
        image: 'assets/images/ps5.png',
        value: 3200,
        probability: 0.017,
      ),
      SliderItemModel(
        title: 'Vale-Compras R\$ 50',
        value: 50.00,
        image: 'assets/images/voucher.png',
        probability: 2.12,
      ),
      SliderItemModel(
        title: 'Fone de Ouvido Bluetooth (R\$ 150)',
        value: 150.00,
        image: 'assets/images/headphone.png',
        probability: 1.25,
      ),
      SliderItemModel(
        title: 'Smartwatch (R\$ 100)',
        value: 100.00,
        image: 'assets/images/smartwatch.png',
        probability: 1.1,
      ),
    ];

    double totalRange = 100000;
    double currentMin = 0;

    for (int i = 0; i < items.length; i++) {
      var item = items[i];
      item.index = i;
      item.minRange = currentMin;
      item.maxRange = currentMin + (totalRange * (item.probability / 100));
      currentMin = item.maxRange! + 1;
    }

    //Verificar items

    // for (var item in items) {
    //   debugPrint(
    //     'Index: ${item.index}, Title: ${item.title}, Value: ${item.value}, Probability: ${item.probability}, MinRange: ${item.minRange}, MaxRange: ${item.maxRange}',
    //   );
    // }

    return items;
  }
}
