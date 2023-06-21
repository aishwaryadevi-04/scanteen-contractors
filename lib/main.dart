import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:scanteen/Contractors/c_FoodList/c_food.dart';
import 'package:scanteen/route_generator.dart';
import 'package:flutter_test/flutter_test.dart';


Future<void> main() async {
  
  await dotenv.load(fileName: ".env");
  runApp(const MaterialApp(
    home: ContractorFood(),
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}
