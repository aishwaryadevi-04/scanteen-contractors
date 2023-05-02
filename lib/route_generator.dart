import 'package:flutter/material.dart';
import 'package:scanteen/Contractors/Add_item/add_item_form.dart';
import 'package:scanteen/Contractors/c_FoodList/c_food.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
   

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => c_food());

      case '/add_item':
        return MaterialPageRoute(
          builder: (_) => add_item(),
        );
    }
    return _errorRoute();
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
      ),
      body: Center(
        child: Text('Error'),
      ),
    );
  });
}
