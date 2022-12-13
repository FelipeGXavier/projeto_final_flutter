import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final/expenses.dart';
import 'package:projeto_final/teste.dart';

import 'inifiniteNewsList.dart';

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
                Tab(icon: Icon(Icons.money)),
                Tab(icon: Icon(Icons.edit_note_sharp)),
                Tab(icon: Icon(Icons.book)),
              ],
            ),
            title: const Text('Gerenciador de Despesas'),
          ),
          body: const TabBarView(
            children: [
              Expenses(),
              Teste(),
              InfiniteScrollPaginatorDemo(),
            ],
          ),
        ),
      ),
    );
  }
}
