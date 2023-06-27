import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanteen/Contractors/Add_item/addapi.dart';
import 'package:scanteen/Contractors/Add_item/error_popup.dart';
import 'package:scanteen/navbar.dart';
import 'header.dart';
import 'package:image_picker/image_picker.dart';

class AddItem extends StatefulWidget {
  //Form to add items
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController foodNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    //Selected index in navbar
    setState(() {
      _selectedIndex = index;
    });
  }

  File? image;

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource source) async {
    var img = await picker.pickImage(source: source);

    setState(() {
      image = File(img!.path);
      String uri = image!.path.split('/').last;
      imageController.text = Uri.decodeComponent(uri);
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
                    child: SizedBox(
                      height: 55.0,
                      child: TextFormField(
                        controller: foodNameController,
                        style: const TextStyle(color: Color(0xFFFCD9B8)),
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
                          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                            return "Enter a valid name";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(41, 0, 41, 0),
                    child: SizedBox(
                      height: 55.0,
                      child: TextFormField(
                        controller: priceController,
                        style: const TextStyle(color: Color(0xFFFCD9B8)),
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
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(41, 0, 41, 0),
                    child: SizedBox(
                        height: 55.0,
                        child: Stack(
                          children: [
                            TextFormField(
                              controller: imageController,
                              style: const TextStyle(color: Color(0xFFFCD9B8)),
                              decoration: InputDecoration(
                                filled: true,
                                hintText: 'Upload Image(optional)',
                                hintStyle: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                        color: Color(0xFF757575),
                                        fontSize: 12)),
                                fillColor: const Color(0XFF292C35),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                contentPadding:
                                    const EdgeInsets.only(left: 20.0),
                              ),
                              textInputAction: TextInputAction.next,
                              enabled:
                                  false, 
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () {
                                  getImage(ImageSource.gallery);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12.0),
                                  child: const Icon(
                                    Icons.upload,
                                    color: Color(0xFFE09145),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(41, 0, 41, 0),
                    child: SizedBox(
                      height: 55.0,
                      child: TextFormField(
                        controller: maxPriceController,
                        style: const TextStyle(color: Color(0xFFFCD9B8)),
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
            const SizedBox(height: 110),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final response = await addFood(
                        foodNameController.text,
                        priceController.text,
                        maxPriceController.text,
                      );
                      if (response != "failed") {
                        Navigator.of(context).pushReplacementNamed('/');
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) =>const ErrorPopup()
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE09145),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(268, 65),
                  ),
                  child: Text(
                    'Add item',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        color: Color(0XFF17181D),
                      ),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
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
