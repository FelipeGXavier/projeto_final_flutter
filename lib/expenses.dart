import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:toggle_switch/toggle_switch.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return ExpensesState();
  }
}

class ExpensesState extends State {
  List<String> data = ["a"];
  int initialIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: SizedBox(
            height: 150,
            width: double.infinity,
            child: Card(
              color: Colors.green,
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "R\$1.000,00",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 5,
                        fontSize: 28,
                        color: Colors.white),
                  )),
            ),
          ),
        ),
        ToggleSwitch(
          initialLabelIndex: initialIndex,
          totalSwitches: 2,
          labels: const ['Hoje', 'Mês'],
          onToggle: (index) {
            setState(() {
              initialIndex = index!;
              if (index == 0) {
                data = ["a"];
              } else {
                data = ["b"];
              }
            });
          },
        ),
        Expanded(
            child: ListView.builder(
          itemCount: data.length,
          prototypeItem: ListTile(
            title: Text(data.first),
          ),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(data[index]),
            );
          },
        ))
      ],
    );
  }
}
