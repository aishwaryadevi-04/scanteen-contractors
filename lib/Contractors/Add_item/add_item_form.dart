import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanteen/Contractors/c_FoodList/c_food_list.dart';
import 'package:scanteen/navbar.dart';
import 'header.dart';


class add_item extends StatefulWidget {
  //Form to add items
  const add_item({super.key});

  @override
  State<add_item> createState() => _add_itemState();
}

class _add_itemState extends State<add_item> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController foodNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    //Selected index in navbar
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addFoodItem() {
    //Add food items to list
    String foodNameValue = foodNameController.text;
    int priceValue = int.tryParse(priceController.text) ?? 0;

    setState(() {
      Map<String, dynamic> foodItem = {
        'f_name': foodNameValue,
        'f_price': priceValue,
      };
      cFoodList.add(foodItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17181D),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Header(),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(41, 0, 41, 0),
                    child: Container(
                      height: 55.0,
                      child: TextFormField(
                        controller: foodNameController,
                        style: TextStyle(color: Color(0xFFFCD9B8)),
                        decoration: InputDecoration(
                            filled: true,
                            hintText: 'Food Name',
                            hintStyle: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    color: Color(0xFF757575), fontSize: 12)),
                            fillColor: const Color(0XFF292C35),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            contentPadding: const EdgeInsets.only(left: 20.0)),
                        validator: (value) {
                          if (value!.isEmpty) return "Food Name is required";
                          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value))
                            return "Enter a valid name";
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(41, 0, 41, 0),
                    child: Container(
                      height: 55.0,
                      child: TextFormField(
                        controller: priceController,
                        style: TextStyle(color: Color(0xFFFCD9B8)),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            filled: true,
                            hintText: 'Food Price',
                            hintStyle: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    color: Color(0xFF757575), fontSize: 12)),
                            fillColor: const Color(0XFF292C35),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            contentPadding: const EdgeInsets.only(left: 20.0)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Price is required';
                          } else if (!RegExp(r'^\d+$').hasMatch(value)) {
                            return 'Invalid price';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(41, 0, 41, 0),
                    child: Container(
                      height: 55.0,
                      child: TextFormField(
                        controller: TextEditingController(),
                        style: TextStyle(color: Color(0xFFFCD9B8)),
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'Upload Image(optional)',
                          hintStyle: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  color: Color(0xFF757575), fontSize: 12)),
                          fillColor: const Color(0XFF292C35),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          contentPadding: const EdgeInsets.only(left: 20.0),
                          suffixIcon: GestureDetector(
                            child: Icon(
                              Icons.upload,
                              color: Color(0xFFE09145),
                            ),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(41, 0, 41, 0),
                    child: Container(
                      height: 55.0,
                      child: TextFormField(
                        style: TextStyle(color: Color(0xFFFCD9B8)),
                        decoration: InputDecoration(
                            filled: true,
                            hintText: 'Max value of the item',
                            hintStyle: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    color: Color(0xFF757575), fontSize: 12)),
                            fillColor: const Color(0XFF292C35),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            contentPadding: const EdgeInsets.only(left: 20.0)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Max value is required';
                          } else if (!RegExp(r'^\d+$').hasMatch(value)) {
                            return 'Invalid price';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 131),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => {
                    if (formKey.currentState!.validate())
                      {_addFoodItem(), Navigator.pushNamed(context, '/')},
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE09145),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(268, 65),
                  ),
                  child: Text('Add item',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            color: Color(0XFF17181D),
                          ),
                          fontSize: 16,
                          fontWeight: FontWeight.normal)),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          NavBar(selectedIndex: _selectedIndex, onTabChange: _onItemTapped),
    );
  }
}
