import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto_final/apIService.dart';
import 'package:projeto_final/model/expenseCategory.dart';
import 'package:projeto_final/model/expenseEntity.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CategoriesWidget();
  }
}

class _CategoriesWidget extends State {
  late String _category;
  List<FinancialMovementCategory> _categories = [];

  @override
  void initState() {
    super.initState();
    _initCategories();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        body: Column(children: [
      ListView(
        padding: const EdgeInsets.only(top: 16.0),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          ElevatedButton(
            child: const Text("Criar Nova Categoria"),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      scrollable: true,
                      title: const Text('Cateogira'),
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                onSaved: (newValue) {
                                  setState(() {
                                    _category = newValue!;
                                  });
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Categoria',
                                  icon: Icon(Icons.confirmation_num),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                            child: const Text("Salvar"),
                            onPressed: () {
                              formKey.currentState!.save();
                              _insertCategory();
                            })
                      ],
                    );
                  });
            },
          ),
          ListView.separated(
            padding: const EdgeInsets.only(top: 16.0),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _categories.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.amber,
                child: Center(
                  child: ListTile(
                    title: Text(
                      _categories[index].category,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 20.0),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            size: 20.0,
                            color: Colors.brown[900],
                          ),
                          onPressed: () {
                            _deleteTask(index);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ],
      ),
    ]));
  }

  void _deleteTask(index) async {
    var category = _categories[index];
    await deleteCategory(category.id);
    var categories = await _mapCategoriesData();
    setState(() {
      _categories = categories;
    });
  }

  void _insertCategory() async {
    var result = await createCategory({"category": _category});
    var newCategory =
        FinancialMovementCategory.fromData(result["id"], result["category"]);
    setState(() {
      _categories.add(newCategory);
    });
  }

  void _initCategories() async {
    var categories = await _mapCategoriesData();
    setState(() {
      _categories = categories;
    });
  }

  _mapCategoriesData() async {
    var categories = await getAllCategories();
    return categories.map((e) {
      return FinancialMovementCategory.fromData(e["value"], e["label"]);
    }).toList();
  }
}
