import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Teste extends StatefulWidget {
  const Teste({super.key});

  @override
  State<StatefulWidget> createState() {
    return TesteState();
  }
}

class TesteState extends State {
  final List<String> entries = <String>['A', 'B', 'C'];

  late Future<List<String>> entry;

  @override
  void initState() {
    super.initState();
    entry = getEntries();
  }

  Future<List<String>> getEntries() {
    List<String> l = ["A", "B", "C"];
    return Future<List<String>>.delayed(
      const Duration(seconds: 2),
      () => l,
    );
  }

  Future<List<String>> getEntries2() {
    List<String> l = ["A", "B", "C", "D"];
    return Future<List<String>>.delayed(
      const Duration(seconds: 2),
      () => l,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: entry,
        builder: (context, snapshot) {
          print(snapshot.data);
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ElevatedButton(
                onPressed: () {
                  setState(() {
                    entry = getEntries2();
                  });
                },
                child: Text("Teste"));
          }
        });
  }
}
