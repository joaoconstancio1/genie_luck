import 'package:flutter/material.dart';
import 'dart:math';

final List<SliderItem> sliderItems = [
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
          const Icon(
            Icons.arrow_drop_down_circle_sharp,
            color: Colors.red,
            size: 30,
          ),
          SizedBox(
            height: 120,
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: (context, index) {
                final item = sliderItems[index % sliderItems.length];
                return Column(
                  children: [
                    SizedBox(
                      width: itemWidth,
                      height:
                          100, // Reduzindo a altura da imagem para dar mais espaço ao texto
                      child: Container(
                        decoration: BoxDecoration(
                          color: item.color ?? Colors.grey[300],
                          image:
                              item.image != null
                                  ? DecorationImage(
                                    image: AssetImage(item.image!),
                                    fit: BoxFit.contain,
                                  )
                                  : null,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        item.title!,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              },
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
