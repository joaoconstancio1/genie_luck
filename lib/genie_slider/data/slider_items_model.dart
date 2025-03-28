class SliderItemModel {
  int index;
  String image;
  String title;
  String description;
  double minRange; // Valor mínimo do intervalo
  double maxRange; // Valor máximo do intervalo
  double value; // Valor do item
  double probability; // Probabilidade em %

  SliderItemModel({
    this.index = 0,
    this.image = '',
    this.title = '',
    this.description = '',
    this.minRange = 0.0,
    this.maxRange = 0.0,
    this.value = 0.0,
    required this.probability,
  });

  static List<SliderItemModel> generateItems() {
    List<SliderItemModel> items = [
      SliderItemModel(
        title: 'R\$ 0,50',
        value: 0.50,
        image: 'assets/images/money.png',
        probability: 19,
      ),
      SliderItemModel(
        title: 'R\$ 0,75',
        value: 0.75,
        image: 'assets/images/money.png',
        probability: 17,
      ),
      SliderItemModel(
        title: 'R\$ 1,25',
        value: 1.25,
        image: 'assets/images/money.png',
        probability: 12,
      ),
      SliderItemModel(
        title: 'R\$ 1,50',
        value: 1.50,
        image: 'assets/images/money.png',
        probability: 14,
      ),
      SliderItemModel(
        title: 'R\$ 1,75',
        image: 'assets/images/money.png',
        value: 1.75,
        probability: 14,
      ),
      SliderItemModel(
        title: 'R\$ 2,00',
        image: 'assets/images/money.png',
        value: 2.00,
        probability: 14,
      ),
      SliderItemModel(
        title: 'iPhone 16',
        image: 'assets/images/iphone16.png',
        value: 5200,
        probability: 0.0015,
      ),
      SliderItemModel(
        title: 'PlayStation 5',
        image: 'assets/images/ps5.png',
        value: 3200,
        probability: 0.0017,
      ),
      SliderItemModel(
        title: 'Vale-Compras',
        value: 50.00,
        image: 'assets/images/voucher.png',
        probability: 0.72,
      ),
      SliderItemModel(
        title: 'Fone de Ouvido Bluetooth',
        value: 150.00,
        image: 'assets/images/headphone.png',
        probability: 0.55,
      ),
      SliderItemModel(
        title: 'Smartwatch',
        value: 100.00,
        image: 'assets/images/smartwatch.png',
        probability: 0.35,
      ),
    ];

    double totalRange = 100000;
    double currentMin = 0;

    for (int i = 0; i < items.length; i++) {
      var item = items[i];
      item.index = i;
      item.minRange = currentMin;
      item.maxRange = currentMin + (totalRange * (item.probability / 100));
      currentMin = item.maxRange + 1;
    }

    return items;
  }
}
