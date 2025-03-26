import 'dart:math';
import 'package:flutter/material.dart';

class SliderItem {
  final String name;
  final Color color;
  final int minRange; // Início do intervalo
  final int maxRange; // Fim do intervalo

  SliderItem(this.name, this.color, this.minRange, this.maxRange);
}

// Ajustei os itens para terem intervalos de 10000 números cada
final List<SliderItem> _items = [
  SliderItem('Item 1', Colors.red, 1, 1000), // 1% (1.000 números)
  SliderItem('Item 2', Colors.blue, 1001, 12000), // 11% (11.000 números)
  SliderItem('Item 3', Colors.green, 12001, 23000), // 11% (11.000 números)
  SliderItem('Item 4', Colors.yellow, 23001, 34000), // 11% (11.000 números)
  SliderItem('Item 5', Colors.orange, 34001, 45000), // 11% (11.000 números)
  SliderItem('Item 6', Colors.purple, 45001, 56000), // 11% (11.000 números)
  SliderItem('Item 7', Colors.pink, 56001, 67000), // 11% (11.000 números)
  SliderItem('Item 8', Colors.teal, 67001, 78000), // 11% (11.000 números)
  SliderItem('Item 9', Colors.brown, 78001, 89000), // 11% (11.000 números)
  SliderItem('Item 10', Colors.cyan, 89001, 100000), // 11% (11.000 números)
];

class SliderExample extends StatefulWidget {
  const SliderExample({super.key});

  @override
  SliderExampleState createState() => SliderExampleState();
}

class SliderExampleState extends State<SliderExample> {
  late ScrollController _scrollController;
  final double _itemWidth = 100;

  int _randomNumber = 0;

  // Função para encontrar o item baseado no número sorteado
  SliderItem _findItemByNumber(int number) {
    return _items.firstWhere(
      (item) => number >= item.minRange && number <= item.maxRange,
      orElse: () => _items[0], // Default caso não encontre (não deve ocorrer)
    );
  }

  void _generateRandomNumber() {
    setState(() {
      _randomNumber =
          Random().nextInt(100000) + 1; // Gera número entre 1 e 100000
      SliderItem selectedItem = _findItemByNumber(_randomNumber);
      print('Número sorteado: $_randomNumber');
      print('Item sorteado: ${selectedItem.name}');
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController =
        ScrollController(initialScrollOffset: _itemWidth * 1000);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infinite Random Slider'),
      ),
      body: Column(
        children: [
          Icon(
            Icons.arrow_drop_down,
            color: Colors.red,
            size: 30,
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: null, // Lista infinita
              itemBuilder: (context, index) {
                final displayIndex = index % _items.length;
                return Container(
                  width: _itemWidth,
                  margin: EdgeInsets.all(8),
                  color: _items[displayIndex].color,
                  child: Center(
                    child: Text(
                      _items[displayIndex].name,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _generateRandomNumber,
            child: Text('Girar Slider'),
          ),
          SizedBox(height: 20),
          Text('Último número sorteado: $_randomNumber'),
          Text(
            'Item sorteado: ${_randomNumber > 0 ? _findItemByNumber(_randomNumber).name : "Nenhum"}',
          ),
        ],
      ),
    );
  }
}
