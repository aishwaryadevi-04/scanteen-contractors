import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanteen/navbar.dart';
import 'edit_header.dart';
import 'package:image_picker/image_picker.dart';

class EditItem extends StatefulWidget {
  Map<String, dynamic> data;

  EditItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    //Selected index in navbar
    setState(() {
      _selectedIndex = index;
    });
  }

  final ImagePicker picker = ImagePicker();

  TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> foodDetails = widget.data;
    File? image = foodDetails['f_image'];
    //to set initial values for image field when edit icon is pressed
    if (image == null) {
      //If no image is present set text as default image
      imageController = TextEditingController(text: 'Default image');
    } else {
      //Decode the image path
      String imagePath = image.path.split('/').last;
      imageController.text = Uri.decodeComponent(imagePath);

      imageController = TextEditingController(text: imageController.text);
    }
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController foodNameController =
        TextEditingController(text: foodDetails['f_name']);
    TextEditingController priceController =
        TextEditingController(text: foodDetails['f_price'].toString());
    TextEditingController maxPriceController =
        TextEditingController(text: foodDetails['f_maxPrice'].toString());

    Future<void> getImage() async {//Get images from file
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final image = File(pickedFile.path);

        setState(() {
          String uri = image.path.split('/').last;
          imageController.text = Uri.decodeComponent(uri);
          foodDetails['f_image'] =
              image; // update the f_image field with the selected image path
        });
      }
    }

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
                    child: Container(
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
                    child: Container(
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
                                  false, // Set enabled to false to prevent manual input
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () {
                                  getImage();
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
                    child: Container(
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
            const SizedBox(height: 131),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => {
                    if (formKey.currentState!.validate())
                      {
                        foodDetails['f_name'] = foodNameController.text,
                        foodDetails['f_price'] =
                            int.parse(priceController.text),
                        foodDetails['f_maxPrice'] =
                            int.parse(maxPriceController.text),
                         foodDetails['f_image'] = image,
                         print('Edited item details:$foodDetails'),
                        Navigator.of(context).pushReplacementNamed('/'),
                      }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE09145),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(268, 65),
                  ),
                  child: Text('Update item',
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
