import 'package:flutter/material.dart';

class SliderItem {
  int? index;
  String? image;
  String? title;
  String? description;
  Color? color;
  double? minRange; // Valor mínimo do intervalo
  double? maxRange; // Valor máximo do intervalo
  double? value; // Valor do item
  double probability; // Probabilidade em %

  SliderItem({
    this.index,
    this.image,
    this.title,
    this.description,
    this.color,
    this.value,
    required this.probability,
  });

  static List<SliderItem> generateItems() {
    List<SliderItem> items = [
      SliderItem(
        index: 0,
        title: 'R\$ 0,75',
        value: 0.75,
        image: 'assets/images/money.png',
        probability: 19.033,
      ),
      SliderItem(
        index: 1,
        title: 'R\$ 1,25',
        value: 1.25,
        image: 'assets/images/money.png',
        probability: 12.143,
      ),
      SliderItem(
        index: 2,
        title: 'R\$ 1,50',
        value: 1.50,
        image: 'assets/images/money.png',
        probability: 14.733,
      ),
      SliderItem(
        index: 3,
        title: 'R\$ 1,75',
        image: 'assets/images/money.png',
        value: 1.75,
        probability: 14.453,
      ),
      SliderItem(
        index: 4,
        title: 'R\$ 2,00',
        image: 'assets/images/money.png',
        value: 2.00,
        probability: 14.487,
      ),
      SliderItem(
        index: 5,
        title: 'iPhone 16',
        image: 'assets/images/iphone16.png',
        value: 5500,
        probability: 0.005,
      ),
      SliderItem(
        index: 6,
        title: 'PlayStation 5',
        image: 'assets/images/ps5.png',
        value: 3200,
        probability: 0.007,
      ),
    ];

    double totalRange = 100000;
    double currentMin = 0;

    for (var item in items) {
      item.minRange = currentMin;
      item.maxRange = currentMin + (totalRange * (item.probability / 100));
      currentMin = item.maxRange!;
    }

    return items;
  }
}
