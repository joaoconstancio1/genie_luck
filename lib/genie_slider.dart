import 'package:flutter/material.dart';
import 'dart:math';

final List<SliderItem> sliderItems = [
  SliderItem(
      index: 0,
      title: 'Title 1',
      color: Colors.red,
      minRange: 1,
      maxRange: 100),
  SliderItem(
      index: 1,
      title: 'Title 2',
      color: Colors.blue,
      minRange: 101,
      maxRange: 200),
  SliderItem(
      index: 2,
      title: 'Title 3',
      color: Colors.green,
      minRange: 201,
      maxRange: 300),
  SliderItem(
      index: 3,
      title: 'Title 4',
      color: Colors.orange,
      minRange: 301,
      maxRange: 400),
  SliderItem(
      index: 4,
      title: 'Title 5',
      color: Colors.purple,
      minRange: 401,
      maxRange: 500),
  SliderItem(
      index: 5,
      title: 'Title 6',
      color: Colors.yellow,
      minRange: 501,
      maxRange: 600),
  SliderItem(
      index: 6,
      title: 'Title 7',
      color: Colors.pink,
      minRange: 601,
      maxRange: 700),
  SliderItem(
      index: 7,
      title: 'Title 8',
      color: Colors.teal,
      minRange: 701,
      maxRange: 800),
  SliderItem(
      index: 8,
      title: 'Title 9',
      color: Colors.cyan,
      minRange: 801,
      maxRange: 900),
  SliderItem(
      index: 9,
      title: 'Title 10',
      color: Colors.brown,
      minRange: 901,
      maxRange: 1000),
];

class GenieSlider extends StatefulWidget {
  const GenieSlider({super.key});

  @override
  State<GenieSlider> createState() => _GenieSliderState();
}

class _GenieSliderState extends State<GenieSlider> {
  int? randomNumber;
  SliderItem? selectedItem;
  final PageController _pageController = PageController(viewportFraction: 0.3);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 120,
            child: Stack(
              children: [
                SizedBox(
                  height: 100,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: sliderItems.length,
                    itemBuilder: (context, index) {
                      final item = sliderItems[index];
                      return Container(
                        width: 100,
                        color: item.color,
                        child: Center(child: Text(item.title!)),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 0,
                  left: MediaQuery.of(context).size.width / 2 - 20,
                  child: const Icon(
                    Icons.arrow_drop_down_circle_sharp,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      randomNumber = Random().nextInt(1000) + 1;
                      // Find the corresponding item based on the random number
                      selectedItem = sliderItems.firstWhere(
                        (item) =>
                            randomNumber! >= item.minRange! &&
                            randomNumber! <= item.maxRange!,
                        orElse: () => sliderItems.first,
                      );
                      // Animate to the selected item's page
                      _pageController.animateToPage(
                        selectedItem!.index!,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    });
                  },
                  child: const Text('Sortear Número'),
                ),
                if (randomNumber != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        Text(
                          'Número sorteado: $randomNumber',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Item correspondente: ${selectedItem!.title} '
                          '(${selectedItem!.minRange}-${selectedItem!.maxRange})',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SliderItem {
  int? index; // Added index
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
}
