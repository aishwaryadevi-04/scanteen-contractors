import 'package:flutter/material.dart';
import 'package:scanteen/Contractors/add_item.dart';
import 'package:scanteen/Contractors/c_food.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const c_food(),
        '/add_item': (context) => const add_item(),
      },
    );
  }
}
