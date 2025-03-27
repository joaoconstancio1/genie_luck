import 'package:flutter/material.dart';
import 'dart:math';

import 'package:genie_luck/slider_itens.dart';

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
    int itemsCount = SliderItem.sliderItems.length;
    const int loops = 3;

    int currentPage = _pageController!.page?.round() ?? 1000;
    int currentIndex = currentPage % itemsCount;

    int stepsToTarget = targetIndex - currentIndex;
    if (stepsToTarget < 0) {
      stepsToTarget += itemsCount;
    }

    final int totalSteps = (itemsCount * loops) + stepsToTarget;
    final int targetPage = currentPage + totalSteps;

    setState(() {
      isSpinning = true; // Bloqueia o botão
    });

    await _pageController!.animateToPage(
      targetPage,
      duration: const Duration(milliseconds: 4000),
      curve: Curves.easeOutExpo,
    );

    setState(() {
      isSpinning = false; // Desbloqueia o botão
    });
  }

  SliderItem _selectItemByPercentage() {
    final random = Random();
    double totalPercentage = SliderItem.sliderItems.fold(
      0,
      (sum, item) => sum + item.percentage!,
    );
    double randomValue = random.nextDouble() * totalPercentage;

    double cumulative = 0;
    for (var item in SliderItem.sliderItems) {
      cumulative += item.percentage!;
      if (randomValue <= cumulative) {
        return item;
      }
    }
    return SliderItem
        .sliderItems
        .last; // Fallback (não deve ocorrer se as porcentagens somam 100)
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
                final item =
                    SliderItem.sliderItems[index %
                        SliderItem.sliderItems.length];
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
                              selectedItem = _selectItemByPercentage();
                              randomNumber =
                                  Random().nextInt(1000) +
                                  1; // Mantido apenas para exibição
                              userBalance -=
                                  costToPlay; // Deduz o custo do saldo
                            });
                            await _animateToItem(selectedItem!.index!);
                          }
                          : null,
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
                          '(${selectedItem!.percentage}%)',
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
