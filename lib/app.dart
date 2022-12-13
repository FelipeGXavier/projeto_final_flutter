import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final/grid.dart';
import 'package:projeto_final/splashScreen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const Splash(),
        '/home': (context) => const GridTabs(),
      },
    );
  }
}
