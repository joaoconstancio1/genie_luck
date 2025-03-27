import 'package:flutter/material.dart';

class SliderItem {
  int? index;
  String? image;
  String? title;
  String? description;
  Color? color;
  double? percentage; // Novo campo para porcentagem

  SliderItem({
    this.index,
    this.image,
    this.title,
    this.description,
    this.color,
    this.percentage,
  });

  static final List<SliderItem> sliderItems = [
    SliderItem(
      index: 0,
      title: 'R\$ 5,00',
      image: 'assets/images/money.png',
      percentage: 2, // 2% de chance
    ),
    SliderItem(
      index: 1,
      title: 'R\$ 0,75',
      image: 'assets/images/money.png',
      percentage: 10, // 10% de chance
    ),
    SliderItem(
      index: 2,
      title: 'PlayStation 5',
      image: 'assets/images/playstation5.png',
      percentage: 0.5, // 0.5% de chance
    ),
    SliderItem(
      index: 3,
      title: 'R\$ 15,00',
      image: 'assets/images/money.png',
      percentage: 1, // 1% de chance
    ),
    SliderItem(
      index: 4,
      title: 'R\$ 1,50',
      image: 'assets/images/money.png',
      percentage: 7, // 7% de chance
    ),
    SliderItem(
      index: 5,
      title: 'R\$ 25,00',
      image: 'assets/images/money.png',
      percentage: 1, // 1% de chance
    ),
    SliderItem(
      index: 6,
      title: 'R\$ 2,50',
      image: 'assets/images/money.png',
      percentage: 4, // 4% de chance
    ),
    SliderItem(
      index: 7,
      title: 'iPhone 16',
      image: 'assets/images/iphone16.png',
      percentage: 0.5, // 0.5% de chance
    ),
    SliderItem(
      index: 8,
      title: 'R\$ 0,25',
      image: 'assets/images/money.png',
      percentage: 20, // 20% de chance
    ),
    SliderItem(
      index: 9,
      title: 'R\$ 3,50',
      image: 'assets/images/money.png',
      percentage: 2, // 2% de chance
    ),
    SliderItem(
      index: 10,
      title: 'R\$ 1,00',
      image: 'assets/images/money.png',
      percentage: 10, // 10% de chance
    ),
    SliderItem(
      index: 11,
      title: 'R\$ 7,50',
      image: 'assets/images/money.png',
      percentage: 1, // 1% de chance
    ),
    SliderItem(
      index: 12,
      title: 'R\$ 0,50',
      image: 'assets/images/money.png',
      percentage: 15, // 15% de chance
    ),
    SliderItem(
      index: 13,
      title: 'R\$ 2,00',
      image: 'assets/images/money.png',
      percentage: 5, // 5% de chance
    ),
    SliderItem(
      index: 14,
      title: 'R\$ 10,00',
      image: 'assets/images/money.png',
      percentage: 1, // 1% de chance
    ),
    SliderItem(
      index: 15,
      title: 'R\$ 1,25',
      image: 'assets/images/money.png',
      percentage: 8, // 8% de chance
    ),
    SliderItem(
      index: 16,
      title: 'R\$ 4,00',
      image: 'assets/images/money.png',
      percentage: 2, // 2% de chance
    ),
    SliderItem(
      index: 17,
      title: 'R\$ 50,00',
      image: 'assets/images/money.png',
      percentage: 1, // 1% de chance
    ),
    SliderItem(
      index: 18,
      title: 'R\$ 1,75',
      image: 'assets/images/money.png',
      percentage: 6, // 6% de chance
    ),
    SliderItem(
      index: 19,
      title: 'R\$ 3,00',
      image: 'assets/images/money.png',
      percentage: 3, // 3% de chance
    ),
  ];
}
