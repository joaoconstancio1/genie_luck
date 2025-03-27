import 'package:flutter/material.dart';

class SliderItem {
  int? index;
  String? image;
  String? title;
  String? description;
  Color? color;
  double? minRange; // Valor mínimo do intervalo
  double? maxRange; // Valor máximo do intervalo
  double? value; // Valor atual do item

  SliderItem({
    this.index,
    this.image,
    this.title,
    this.description,
    this.color,
    this.minRange,
    this.maxRange,
    this.value,
  });

  static final List<SliderItem> sliderItems = [
    SliderItem(
      index: 0,
      title: 'R\$ 2,00',
      image: 'assets/images/money.png',
      minRange: 1,
      maxRange: 100,
      value: 2, // Mesmo valor do título
    ),
    SliderItem(
      index: 1,
      title: 'R\$ 5,00',
      image: 'assets/images/money.png',
      minRange: 101,
      maxRange: 200,
      value: 5, // Mesmo valor do título
    ),
    SliderItem(
      index: 2,
      title: 'iPhone 16',
      image: 'assets/images/iphone16.png',
      minRange: 201,
      maxRange: 300,
      value: 5500, // Valor aproximado
    ),
    SliderItem(
      index: 3,
      title: 'R\$ 10,00',
      image: 'assets/images/money.png',
      minRange: 301,
      maxRange: 400,
      value: 10, // Mesmo valor do título
    ),
    SliderItem(
      index: 4,
      title: 'PlayStation 5',
      image: 'assets/images/ps5.png',
      minRange: 401,
      maxRange: 500,
      value: 3200, // Valor aproximado
    ),
    SliderItem(
      index: 5,
      title: 'R\$ 50,00',
      image: 'assets/images/money.png',
      minRange: 501,
      maxRange: 600,
      value: 50, // Mesmo valor do título
    ),
    SliderItem(
      index: 6,
      title: 'R\$ 100,00',
      image: 'assets/images/money.png',
      minRange: 601,
      maxRange: 700,
      value: 100, // Mesmo valor do título
    ),
    SliderItem(
      index: 7,
      title: 'R\$ 5,00',
      image: 'assets/images/money.png',
      minRange: 701,
      maxRange: 800,

      value: 5, // Mesmo valor do título
    ),
  ];
}
