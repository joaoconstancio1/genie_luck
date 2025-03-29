import 'package:flutter/material.dart';
import 'dart:math';

import 'package:genie_luck/genie_slider/data/slider_items_model.dart';

class GenieSlider extends StatefulWidget {
  const GenieSlider({super.key});

  @override
  State<GenieSlider> createState() => _GenieSliderState();
}

class _GenieSliderState extends State<GenieSlider> {
  int? randomNumber;
  SliderItemModel? selectedItem;
  PageController? _pageController;
  double itemWidth = 100.0;
  bool isSpinning = false;
  double userBalance = 200.0;

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  List<SliderItemModel> sliderItems = SliderItemModel.generateItems();

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

    setState(() {
      isSpinning = true;
    });

    await _pageController!.animateToPage(
      targetPage,
      duration: const Duration(milliseconds: 4000),
      curve: Curves.easeOutExpo,
    );

    // Após a animação, adiciona o valor do item ao saldo
    setState(() {
      isSpinning = false;
      if (selectedItem?.value != null) {
        userBalance += selectedItem!.value;
      }
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

    const double costToPlay = 5;
    const double defaultPadding = 16.0;

    return Scaffold(
      body: ListView(
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
                final item = sliderItems[index % sliderItems.length];
                return SizedBox(
                  width: itemWidth,
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          item.image.isNotEmpty
                              ? item.image
                              : 'assets/images/genie.jpg',
                        ),
                        fit: BoxFit.contain,
                      ),
                      border: Border.all(color: Colors.grey, width: 0.5),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.black.withAlpha(150),
                        padding: const EdgeInsets.symmetric(
                          vertical: 2.0,
                          horizontal: 4.0,
                        ),
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed:
                    (userBalance >= costToPlay && !isSpinning)
                        ? () async {
                          setState(() {
                            userBalance -= costToPlay;
                            randomNumber = Random().nextInt(100000);
                            selectedItem = sliderItems.firstWhere(
                              (item) =>
                                  randomNumber! >= item.minRange &&
                                  randomNumber! <= item.maxRange,
                              orElse: () => sliderItems.first,
                            );
                          });
                          await _animateToItem(selectedItem!.index);
                        }
                        : null,
                child: Text(
                  userBalance >= costToPlay
                      ? 'Sortear Número (R\$ 5,00)'
                      : 'Saldo insuficiente',
                ),
              ),
              if (randomNumber != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: [
                      Text(
                        'Número sorteado: ${randomNumber!}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Item correspondente: ${selectedItem!.title} '
                        '(Intervalo: ${selectedItem!.minRange} - ${selectedItem!.maxRange})',
                        style: const TextStyle(fontSize: 16),
                      ),
                      if (selectedItem?.value != null)
                        Text(
                          'Prêmio: R\$ ${selectedItem!.value.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                    ],
                  ),
                ),
              SizedBox(height: 20),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    (MediaQuery.of(context).size.width ~/ 120).toInt(),
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.8,
              ),
              itemCount: sliderItems.length,
              itemBuilder: (context, index) {
                final item = sliderItems[index];
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey, width: 0.5),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${item.probability}%',
                          style: TextStyle(
                            color: Colors.black.withAlpha((180)),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                item.image.isNotEmpty
                                    ? item.image
                                    : 'assets/images/genie.jpg',
                              ),
                              fit: BoxFit.contain,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      Text(
                        formatTitlePlusValue(item.title, item.value),
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String formatTitlePlusValue(String title, double value) {
    String formattedValue = value.toStringAsFixed(2).replaceAll('.', ',');
    formattedValue = formattedValue.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+,)'),
      (Match m) => '${m[1]}.',
    );
    return '$title\n(R\$ $formattedValue)';
  }
}
