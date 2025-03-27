import 'package:flutter/material.dart';
import 'dart:math';

final List<SliderItem> sliderItems = [
  SliderItem(
    index: 0,
    title: 'Title 1',
    color: Colors.red,
    minRange: 1,
    maxRange: 100,
  ),
  SliderItem(
    index: 1,
    title: 'Title 2',
    color: Colors.blue,
    minRange: 101,
    maxRange: 200,
  ),
  SliderItem(
    index: 2,
    title: 'Title 3',
    color: Colors.green,
    minRange: 201,
    maxRange: 300,
  ),
  SliderItem(
    index: 3,
    title: 'Title 4',
    color: Colors.orange,
    minRange: 301,
    maxRange: 400,
  ),
  SliderItem(
    index: 4,
    title: 'Title 5',
    color: Colors.purple,
    minRange: 401,
    maxRange: 500,
  ),
  SliderItem(
    index: 5,
    title: 'Title 6',
    color: Colors.yellow,
    minRange: 501,
    maxRange: 600,
  ),
  SliderItem(
    index: 6,
    title: 'Title 7',
    color: Colors.pink,
    minRange: 601,
    maxRange: 700,
  ),
  SliderItem(
    index: 7,
    title: 'Title 8',
    color: Colors.teal,
    minRange: 701,
    maxRange: 800,
  ),
  SliderItem(
    index: 8,
    title: 'Title 9',
    color: Colors.cyan,
    minRange: 801,
    maxRange: 900,
  ),
  SliderItem(
    index: 9,
    title: 'Title 10',
    color: Colors.brown,
    minRange: 901,
    maxRange: 1000,
  ),
];

class GenieSlider extends StatefulWidget {
  const GenieSlider({super.key});

  @override
  State<GenieSlider> createState() => _GenieSliderState();
}

class _GenieSliderState extends State<GenieSlider> {
  int? randomNumber;
  SliderItem? selectedItem;
  PageController? _pageController;
  double itemWidth =
      100.0; // Largura inicial dos itens, será ajustada dinamicamente

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  Future<void> _animateToItem(int targetIndex) async {
    int itemsCount = sliderItems.length;
    const int loops = 3;

    int currentPage = _pageController!.page?.round() ?? 1000;
    int currentIndex = currentPage % itemsCount;

    int stepsToTarget = targetIndex - currentIndex;
    if (stepsToTarget < 0) {
      stepsToTarget += itemsCount;
    }

    final int totalSteps = (itemsCount * loops) + stepsToTarget;
    final int targetPage = currentPage + totalSteps;

    await _pageController!.animateToPage(
      targetPage,
      duration: const Duration(milliseconds: 4000),
      curve: Curves.easeOutExpo,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Número de itens que queremos visíveis ao mesmo tempo
    const int visibleItems = 5; // Ajustado para 5 itens visíveis

    // Calcula a largura da tela
    double screenWidth = MediaQuery.of(context).size.width;

    // Calcula a largura dos itens para que 5 itens sejam visíveis ao mesmo tempo
    itemWidth = screenWidth / visibleItems;

    // Calcula o viewportFraction com base na largura dos itens
    double viewportFraction = itemWidth / screenWidth;

    // Inicializa o PageController
    _pageController ??= PageController(
      initialPage: 1000,
      viewportFraction: viewportFraction,
    );

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
                      return SizedBox(
                        width: itemWidth, // Largura ajustada dinamicamente
                        height: 80, // Altura fixa
                        child: Container(
                          color: item.color,
                          child: Center(
                            child: Text(
                              item.title!,
                              style: TextStyle(
                                fontSize:
                                    16 *
                                    (itemWidth /
                                        100), // Ajusta o tamanho da fonte proporcionalmente
                              ),
                            ),
                          ),
                        ),
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
