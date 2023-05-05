import 'package:flutter/material.dart';
import 'package:scanteen/Contractors/Add_item/add_item_form.dart';
import 'package:scanteen/Contractors/c_FoodList/c_food.dart';
import 'package:scanteen/Contractors/c_FoodList/edit_item.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
   
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const ContractorFood());

      case '/add_item':
        return MaterialPageRoute(
          builder: (_) => const AddItem(),
        );

      case '/edit_item':
       final args = settings.arguments as  Map<String,dynamic>;
        return MaterialPageRoute(
          builder: (_) => EditItem(data: args),
        );
    }
    return _errorRoute();
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('Error'),
      ),
    );
  });
}
