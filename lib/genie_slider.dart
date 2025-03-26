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
  final PageController _pageController = PageController(
    viewportFraction: 0.3,
    initialPage: 1000,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _animateToItem(int targetIndex) async {
    int itemsCount = sliderItems.length;
    const int loops = 3; // 3 voltas completas

    // Get the current page (as an integer)
    int currentPage =
        _pageController.page?.round() ?? _pageController.initialPage;

    // Normalize the current page to a value within the range of sliderItems
    int currentIndex = currentPage % itemsCount;

    // Calculate how many steps to reach the target index after 3 loops
    int stepsToTarget = targetIndex - currentIndex;
    if (stepsToTarget < 0) {
      stepsToTarget += itemsCount; // Ensure we move forward
    }

    // Total steps: 3 full loops + steps to the target
    final int totalSteps = (itemsCount * loops) + stepsToTarget;
    final int targetPage = currentPage + totalSteps;

    // Animate to the target page
    await _pageController.animateToPage(
      targetPage,
      duration: const Duration(milliseconds: 4000),
      curve: Curves.easeOutExpo,
    );
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
                    itemBuilder: (context, index) {
                      final item = sliderItems[index % sliderItems.length];
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
                  onPressed: () async {
                    setState(() {
                      randomNumber = Random().nextInt(1000) + 1;
                      selectedItem = sliderItems.firstWhere(
                        (item) =>
                            randomNumber! >= item.minRange! &&
                            randomNumber! <= item.maxRange!,
                        orElse: () => sliderItems.first,
                      );
                    });
                    await _animateToItem(selectedItem!.index!);
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
}
