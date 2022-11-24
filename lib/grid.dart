import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final/expenses.dart';

class GridTabs extends StatelessWidget {
  const GridTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: const Text('Gerenciador de Despesas'),
          ),
          body: const TabBarView(
            children: [
              Icon(Icons.directions_car),
              Expenses(),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
