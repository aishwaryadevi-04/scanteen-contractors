import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanteen/Contractors/c_food_list.dart';
import 'package:scanteen/navbar.dart';

class c_food extends StatefulWidget {//Display food list of contractors
  const c_food({super.key});

  @override
  State<c_food> createState() => _c_foodState();
}

class _c_foodState extends State<c_food> {
  List<Map<String, dynamic>> _filteredFood = [];

  initState() {
    _filteredFood = cFoodList;
    super.initState();
  }

  void _filterFood(String input) {
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
      _filteredFood = results;
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    //Selected index in navbar
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Scaffold(
          backgroundColor: const Color(0xFF17181D),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 77, 16, 0),
                  child: Text(
                    'Frost Bite',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        color: Color(0xFFFCD9B8),
                      ),
                      fontSize: 35,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Divider(
                          color: const Color(0xFFBDBDBD).withOpacity(0.1),
                          thickness: 1.0,
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 26, 16, 33),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) => _filterFood(value),
                        style: const TextStyle(color: Color(0xFFBDBDBD)),
                        decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.search,color:const Color(0xFF757575)),
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
                  children: _filteredFood.map((food) {
                    String foodName = food['f_name'] ?? '';
                    int foodPrice = food['f_price'] ?? 0;

                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 33),
                      child: Container(
                        width: 361.0,
                        height: 243.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0XFF292C35),
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
                                    color: const Color(0XFF757575)),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 6.0),
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
                                    const Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Icon(Icons.edit_outlined,
                                          color: Color(0xFFE09145)),
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
                                            return AlertDialog(
                                              backgroundColor:
                                                  Color(0XFF2B2B2B),
                                              content: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Text(
                                                    'Do you want to delete?',
                                                    style: TextStyle(
                                                      color: Color(0xFFFCD9B8),
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              actions: <Widget>[
                                                Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        GestureDetector(
                                                          child: const Text(
                                                            'Delete',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFFE09145),
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(true);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 250,
                                                      child: Divider(
                                                        color: const Color(
                                                                0xFFBDBDBD)
                                                            .withOpacity(0.1),
                                                        thickness: 1.0,
                                                      ),
                                                    ),
                                                    SizedBox(height: 20),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        GestureDetector(
                                                          child: const Text(
                                                            'Cancel',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF757575),
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(false);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 250,
                                                      child: Divider(
                                                        color: const Color(
                                                                0xFFBDBDBD)
                                                            .withOpacity(0.1),
                                                        thickness: 1.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        //Remove food item
                                        if (confirmed == true) {
                                          setState(() {
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
      ),
    );
  }
}
