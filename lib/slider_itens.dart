import 'package:flutter/material.dart';

class SliderItem {
  int? index;
  String? image;
  String? title;
  String? description;
  Color? color;
  int? minRange;
  int? maxRange;

  SliderItem({
    this.index,
    this.image,
    this.title,
    this.description,
    this.color,
    this.minRange,
    this.maxRange,
  });

  static final List<SliderItem> sliderItems = [
    SliderItem(
      index: 0,
      title: 'R\$ 2,00',
      image: 'assets/images/money.png',
      minRange: 1,
      maxRange: 100,
    ),
    SliderItem(
      index: 1,
      title: 'R\$ 5,00',
      image: 'assets/images/money.png',
      minRange: 101,
      maxRange: 200,
    ),
    SliderItem(
      index: 2,
      title: 'iPhone 16',
      image: 'assets/images/iphone16.png',
      minRange: 201,
      maxRange: 300,
    ),
    SliderItem(
      index: 3,
      title: 'R\$ 10,00',
      image: 'assets/images/money.png',
      minRange: 301,
      maxRange: 400,
    ),
    SliderItem(
      index: 4,
      title: 'PlayStation 5',
      image: 'assets/images/playstation5.png',
      minRange: 401,
      maxRange: 500,
    ),
    SliderItem(
      index: 5,
      title: 'R\$ 50,00',
      image: 'assets/images/money.png',
      minRange: 501,
      maxRange: 600,
    ),
    SliderItem(
      index: 6,
      title: 'R\$ 100,00',
      image: 'assets/images/money.png',
      minRange: 601,
      maxRange: 700,
    ),
    SliderItem(
      index: 7,
      title: 'R\$ 5,00',
      image: 'assets/images/money.png',
      minRange: 701,
      maxRange: 800,
    ),
    SliderItem(
      index: 8,
      title: 'R\$ 5,00',
      image: 'assets/images/money.png',
      minRange: 801,
      maxRange: 900,
    ),
    SliderItem(
      index: 9,
      title: 'R\$ 5,00',
      image: 'assets/images/money.png',
      minRange: 901,
      maxRange: 1000,
    ),
  ];
}
