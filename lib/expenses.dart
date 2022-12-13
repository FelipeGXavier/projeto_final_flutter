import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto_final/apIService.dart';
import 'package:projeto_final/model/expenseEntity.dart';

import 'package:toggle_switch/toggle_switch.dart';
import 'package:select_form_field/select_form_field.dart';

import 'package:http/http.dart' as http;

import 'model/expenseCategory.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return ExpensesState();
  }
}

enum ExpenseType { income, expense }

class ExpensesState extends State {
  List<String> data = ["a"];
  int initialIndex = 0;

  int _category = 0;
  String _type = "";
  double _value = 0.0;
  String _title = "";

  double _currentExpense = 0.0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<Map<String, dynamic>> _types = [
    {
      'value': 0,
      'label': 'Despesa',
      'icon': Icon(Icons.arrow_downward),
    },
    {
      'value': 1,
      'label': 'Entrada',
      'icon': Icon(Icons.arrow_upward),
      'textStyle': TextStyle(color: Colors.red),
    },
  ];

  late Future<List<FinancialMovement>> entry;
  late Future<List<Map<String, dynamic>>> entry2;
  late Future<double> entry3;

  @override
  void initState() {
    super.initState();
    entry = loadExpenses();
    entry2 = loadCategories();
    loadBalance();
  }

  Future<List<FinancialMovement>> loadExpenses() async {
    const basePath = "http://10.0.2.2:3000";
    const path = "$basePath/expenses";
    var res = await http.get(
      Uri.parse(path),
    );
    var bodyResponse = jsonDecode(res.body);
    var data = {
      "categories": bodyResponse['categories'],
      "expenses": bodyResponse['expenses']
    };
    List<Map<String, dynamic>> rawExpensesData =
        List<Map<String, dynamic>>.from(data['expenses']);
    List<FinancialMovement> expenses = [];
    for (var element in rawExpensesData) {
      expenses.add(FinancialMovement.fromMap(element));
    }
    return expenses;
  }

  Future<List<Map<String, dynamic>>> loadCategories() async {
    const basePath = "http://10.0.2.2:3000";
    const path = "$basePath/categories";
    var res = await http.get(
      Uri.parse(path),
    );
    var bodyResponse = jsonDecode(res.body);
    var data = {
      "categories": bodyResponse['categories'],
      "expenses": bodyResponse['expenses']
    };
    List<Map<String, dynamic>> categories =
        List<Map<String, dynamic>>.from(data['categories']);
    return categories;
  }

  loadBalance() async {
    const basePath = "http://10.0.2.2:3000";
    const path = "$basePath/current-balance";
    var res = await http.get(
      Uri.parse(path),
    );
    var bodyResponse = jsonDecode(res.body);
    setState(() {
      _currentExpense = double.parse(bodyResponse["balance"].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([entry, entry2]),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<FinancialMovement> expenses =
              snapshot.data![0] as List<FinancialMovement>;
          List<Map<String, dynamic>> categories =
              snapshot.data![1] as List<Map<String, dynamic>>;
          var balance = expenses.fold(0.0, (sum, item) {
            if (item.type) {
              return sum + item.value;
            } else {
              return sum - item.value;
            }
          });
          print(_currentExpense);
          return buildWidget(categories, expenses, balance);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildWidget(List<Map<String, dynamic>> categories,
      List<FinancialMovement> expenses, double balance) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            height: 150,
            width: double.infinity,
            child: Card(
                color: Colors.green,
                child: Center(
                  child: Text(
                    "R\$ $_currentExpense",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 5,
                        fontSize: 28,
                        color: Colors.white),
                  ),
                )),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToggleSwitch(
                initialLabelIndex: initialIndex,
                totalSwitches: 2,
                labels: const ['Hoje', 'Mês'],
                onToggle: (index) async {
                  var t = await Future.delayed(const Duration(seconds: 1), () {
                    return ["d"];
                  });
                  setState(() {
                    initialIndex = index!;
                    if (index == 0) {
                      data = t;
                    } else {
                      data = t;
                    }
                  });
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(10)),
                child: const Icon(
                  Icons.add,
                  size: 12,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          title: const Text('Criar Movimentação'),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Nome Movimentação',
                                      icon: Icon(Icons.account_box),
                                    ),
                                    onChanged: (value) => {
                                      setState(() => {_title = value})
                                    },
                                  ),
                                  SelectFormField(
                                    type: SelectFormFieldType
                                        .dropdown, // or can be dialog
                                    initialValue: 'circle',
                                    icon: const Icon(Icons.format_shapes),
                                    labelText: 'Categoria',
                                    items: categories,
                                    onChanged: (val) => setState(() {
                                      _category = int.parse(val);
                                    }),
                                    onSaved: (val) => print(val),
                                  ),
                                  SelectFormField(
                                    type: SelectFormFieldType
                                        .dropdown, // or can be dialog
                                    initialValue: 'circle',
                                    icon: const Icon(Icons.money),
                                    labelText: 'Tipo',
                                    items: _types,
                                    onChanged: (val) => setState(() {
                                      _type = val;
                                    }),
                                    onSaved: (val) => print(val),
                                  ),
                                  TextFormField(
                                    onChanged: (value) => {
                                      setState(
                                          () => _value = double.parse(value))
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Valor Movimentação',
                                      icon: Icon(Icons.currency_bitcoin),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                                child: const Text("Adicionar"),
                                onPressed: () async {
                                  _formKey.currentState!.save();
                                  var category =
                                      FinancialMovementCategory(_category);
                                  bool typeOfMovement =
                                      _type == "0" ? false : true;
                                  var movement = FinancialMovement(
                                      _title, typeOfMovement, _value, category);
                                  //print(jsonEncode(movement));
                                  await createExpense(movement);
                                  await loadBalance();
                                  setState(() {
                                    entry = loadExpenses();
                                  });
                                })
                          ],
                        );
                      });
                },
              ),
            ],
          ),
        ),
        Expanded(
            child: ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: expenses[index].type
                    ? const Icon(Icons.arrow_upward)
                    : const Icon(Icons.arrow_downward),
                title: Text(expenses[index].title),
                subtitle: Text(
                    'R\$ ${expenses[index].value} - ${(expenses[index].category as FinancialMovementCategory).category}'),
              ),
            );
          },
        ))
      ],
    );
  }
}
