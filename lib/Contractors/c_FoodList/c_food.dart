import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanteen/Contractors/c_FoodList/c_food_list.dart';
import 'package:scanteen/Contractors/c_FoodList/delete_popup.dart';
import 'package:scanteen/Contractors/c_FoodList/c_header.dart';
import 'package:scanteen/navbar.dart';

class ContractorFood extends StatefulWidget {
  //Display food list of contractors
  const ContractorFood({super.key});

  @override
  State<ContractorFood> createState() => ContractorFoodState();
}

class ContractorFoodState extends State<ContractorFood> {
  @override
  initState() {
    filteredFood = cFoodList;
    super.initState();
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    //Selected index in navbar
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Map<String, dynamic>> filteredFood = [];
  void filterFood(String input) {
    //Filter food with input from searchbox
    List<Map<String, dynamic>> results = [];
    if (input.isEmpty) {
      results = cFoodList;
    } else {
      results = cFoodList
          .where((food) =>
              food["f_name"].toLowerCase().contains(input.toLowerCase()))
          .toList();
    }
    setState(() {
      filteredFood = results;
      print('Filtered food : $filteredFood');
    });
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF17181D),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const ContractorHeader(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 26, 16, 33),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) => filterFood(value),
                      style: const TextStyle(color: Color(0xFFBDBDBD)),
                      decoration: InputDecoration(
                          filled: true,
                          prefixIcon: const Icon(Icons.search,
                              color: Color(0xFF757575)),
                          hintText: 'Search',
                          hintStyle: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  color: Color(0xFF757575), fontSize: 13)),
                          fillColor: const Color(0XFF2B2B2B),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          contentPadding: const EdgeInsets.only(left: 50.0)),
                    ),
                  ],
                ),
              ),
              Column(
                children: filteredFood.map((food) {
                  String foodName = food['f_name'] ?? '';
                  int foodPrice = food['f_price'] ?? 0;
                  File? foodImage = food['f_image'] ?? null;
                  int maxPrice = food['f_maxPrice'] ?? 0;
                  index = index + 1;
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, bottom: 33),
                    child: Container(
                      width: 361.0,
                      height: 243.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0XFF292C35),
                      ),
                      padding: const EdgeInsets.only(top: 0, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              width: 361.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0XFF757575),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 60, right: 60.0, top: 0, bottom: 0),
                                child: Container(
                                  width: double.infinity,
                                  height: 243.0,
                                  child: foodImage == null
                                      ? Image.asset('assets/food.jfif',
                                          fit: BoxFit.fitWidth)
                                      : Image.file(foodImage,
                                          fit: BoxFit.fitWidth),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 6.0),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    foodName,
                                    style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                        color: Color(0xFFFCD9B8),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          '/edit_item',
                                          arguments: food);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Icon(Icons.edit_outlined,
                                          color: Color(0xFFE09145)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Rs. $foodPrice/-',
                                    style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                        color: Color(0xFF757575),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      //Index of selected food to delete
                                      int index = cFoodList.indexWhere(
                                          (foodItem) =>
                                              foodItem['f_name'] == foodName);
                                      bool confirmed = await showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return const DeleteFood();
                                        },
                                      );
                                      //Remove food item
                                      if (confirmed == true) {
                                        setState(() {
                                          Map<String, dynamic> deletedItem =
                                              cFoodList[index];
                                          print('Deleted food details : $deletedItem');
                                          cFoodList.removeAt(index);
                                        });
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.delete,
                                        color: Color(0xFFE09145),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavBar(
          selectedIndex: _selectedIndex,
          onTabChange: _onItemTapped,
        ),
      ),
    );
  }
}
