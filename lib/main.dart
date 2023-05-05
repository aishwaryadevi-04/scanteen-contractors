import 'package:flutter/material.dart';
import 'package:scanteen/Contractors/c_FoodList/c_food.dart';
import 'package:scanteen/route_generator.dart';

void main() {
  runApp(const MaterialApp(
    home:ContractorFood(),
    onGenerateRoute:RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}


