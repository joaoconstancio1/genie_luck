import 'dart:math';

import 'package:flutter/material.dart';
import 'package:genie_luck/modules/genie_slider/data/slider_items_model.dart';

class SimulationPage extends StatefulWidget {
  const SimulationPage({super.key});

  @override
  State<SimulationPage> createState() => _SimulationPageState();
}

class _SimulationPageState extends State<SimulationPage> {
  static const int numberOfPlayers = 1000;
  static const int numberOfRounds = 10;
  static const double startingBalance = 100.0;
  static const double costToPlay = 5;

  final List<Map<String, dynamic>> players = List.generate(
    numberOfPlayers,
    (index) => {
      'id': index + 1,
      'balance': startingBalance,
      'prizes':
          <
            Map<String, dynamic>
          >[], // Lista para armazenar os prêmios de cada jogador
      'isExpanded': false, // Controla a expansão da lista de prêmios
    },
  );

  final List<SliderItemModel> sliderItems = SliderItemModel.generateItems();
  final Random random = Random();

  double totalSpent = 0.0;
  double totalPrizes = 0.0;

  void runSimulation() {
    for (var player in players) {
      for (int i = 0; i < numberOfRounds; i++) {
        if (player['balance'] >= costToPlay) {
          player['balance'] -= costToPlay;
          totalSpent += costToPlay;

          int randomNumber = random.nextInt(100000);
          var selectedItem = sliderItems.firstWhere(
            (item) =>
                randomNumber >= item.minRange && randomNumber <= item.maxRange,
            orElse: () => sliderItems.first,
          );

          player['balance'] += selectedItem.value;
          player['prizes'].add({
            'round': i + 1,
            'item': selectedItem.title,
            'value': selectedItem.value,
            'range': '${selectedItem.minRange} - ${selectedItem.maxRange}',
          });

          totalPrizes += selectedItem.value;
        }
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    runSimulation();
  }

  double get averageFinalBalance {
    double totalBalance = players.fold(
      0.0,
      (sum, player) => sum + player['balance'],
    );
    return totalBalance / players.length;
  }

  double get maxFinalBalance {
    return players.fold(
      0.0,
      (max, player) => player['balance'] > max ? player['balance'] : max,
    );
  }

  double get minFinalBalance {
    return players.fold(
      1000000.0,
      (min, player) => player['balance'] < min ? player['balance'] : min,
    );
  }

  double get bankProfit {
    return totalSpent - totalPrizes;
  }

  double get bankProfitPercentage {
    if (totalSpent == 0) return 0.0;
    return (bankProfit / totalSpent) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simulação de Sorteios')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Resumo inicial
            Text('Resumo da Simulação'),
            const SizedBox(height: 8),
            Text(
              'Total gasto pelos jogadores: R\$ ${totalSpent.toStringAsFixed(2)}',
            ),
            Text(
              'Total de prêmios pagos: R\$ ${totalPrizes.toStringAsFixed(2)}',
            ),

            Text(
              'Maior saldo final: R\$ ${maxFinalBalance.toStringAsFixed(2)}',
            ),
            Text(
              'Menor saldo final: R\$ ${minFinalBalance.toStringAsFixed(2)}',
            ),
            const SizedBox(height: 8),
            Text(
              'Saldo final médio dos jogadores: R\$ ${averageFinalBalance.toStringAsFixed(2)}',
            ),
            Text('Valor ganho da banca: R\$ ${bankProfit.toStringAsFixed(2)}'),
            Text(
              'Porcentagem de ganho da banca: ${bankProfitPercentage.toStringAsFixed(2)}%',
            ),
            const Divider(height: 20),

            // Lista de jogadores
            Expanded(
              child: ListView.builder(
                itemCount: players.length,
                itemBuilder: (context, index) {
                  // Ordena os jogadores por saldo em ordem decrescente
                  final sortedPlayers = List<Map<String, dynamic>>.from(players)
                    ..sort((a, b) => b['balance'].compareTo(a['balance']));
                  final player = sortedPlayers[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text('Jogador ${player['id']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Saldo final: R\$ ${player['balance'].toStringAsFixed(2)}',
                          ),
                          Text(
                            'Total de prêmios: R\$ ${player['prizes'].fold(0, (sum, val) => sum + val['value']).toStringAsFixed(2)}',
                          ),
                          // Expansão da lista de prêmios
                          if (player['prizes'].isNotEmpty)
                            InkWell(
                              onTap: () {
                                setState(() {
                                  player['isExpanded'] = !player['isExpanded'];
                                });
                              },
                              child: Column(
                                children: [
                                  const SizedBox(height: 8.0),
                                  Text(
                                    player['isExpanded']
                                        ? 'Ver prêmios (clicar para minimizar)'
                                        : 'Ver prêmios (clicar para expandir)',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  if (player['isExpanded'])
                                    Column(
                                      children:
                                          player['prizes'].map<Widget>((prize) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 4.0,
                                                  ),
                                              child: Text(
                                                'Rodada ${prize['round']}: ${prize['item']} (Valor: R\$ ${prize['value'].toStringAsFixed(2)})',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
