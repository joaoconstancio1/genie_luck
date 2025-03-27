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
  double itemWidth = 100.0;
  double userBalance = 5.0; // Saldo inicial mockado de R$ 5,00
  bool isSpinning = false; // Controla se a roleta está girando

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

    // Inicia a animação
    setState(() {
      isSpinning = true; // Bloqueia o botão
    });

    await _pageController!.animateToPage(
      targetPage,
      duration: const Duration(milliseconds: 4000),
      curve: Curves.easeOutExpo,
    );

    // Termina a animação
    setState(() {
      isSpinning = false; // Desbloqueia o botão
    });
  }

  @override
  Widget build(BuildContext context) {
    const int visibleItems = 5;
    double screenWidth = MediaQuery.of(context).size.width;
    itemWidth = screenWidth / visibleItems;
    double viewportFraction = itemWidth / screenWidth;

    _pageController ??= PageController(
      initialPage: 1000,
      viewportFraction: viewportFraction,
    );

    const double costToPlay = 2.0; // Custo fixo de R$ 2,00

    return Scaffold(
      body: Column(
        children: [
          // Exibição do saldo no topo
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Saldo: R\$ ${userBalance.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
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
                      height: 100,
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
                  onPressed:
                      (userBalance >= costToPlay && !isSpinning)
                          ? () async {
                            setState(() {
                              randomNumber = Random().nextInt(1000) + 1;
                              selectedItem = sliderItems.firstWhere(
                                (item) =>
                                    randomNumber! >= item.minRange! &&
                                    randomNumber! <= item.maxRange!,
                                orElse: () => sliderItems.first,
                              );
                              userBalance -=
                                  costToPlay; // Deduz o custo do saldo
                            });
                            await _animateToItem(selectedItem!.index!);
                          }
                          : null, // Botão desabilitado se saldo insuficiente ou girando
                  child: Text(
                    userBalance >= costToPlay
                        ? 'Sortear Número (R\$ 2,00)'
                        : 'Saldo insuficiente',
                  ),
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

void main() {
  runApp(const MaterialApp(home: GenieSlider()));
}
