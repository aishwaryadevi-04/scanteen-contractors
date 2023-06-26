import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:scanteen/Contractors/Add_item/add_item_form.dart';
import 'package:scanteen/Contractors/c_FoodList/c_food.dart';
import 'package:scanteen/Contractors/c_FoodList/edit_item.dart';


Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MaterialApp(
    home: const ContractorFood(),
    
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      
      '/add_item': (context) => const AddItem(),
      '/edit_item': (context) {
        final args =
            ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
        return EditItem(data: args);
      }
    },
  ));
}
