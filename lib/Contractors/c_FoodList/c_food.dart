import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanteen/Contractors/c_FoodList/c_api.dart';
import 'package:scanteen/Contractors/c_FoodList/delete_popup.dart';
import 'package:scanteen/Contractors/c_FoodList/c_header.dart';
import 'package:scanteen/Contractors/c_FoodList/loginapi.dart';
import 'package:scanteen/navbar.dart';

class ContractorFood extends StatefulWidget {
  //Display food list of contractors
  const ContractorFood({super.key});

  @override
  State<ContractorFood> createState() => ContractorFoodState();
}

class ContractorFoodState extends State<ContractorFood> {
  List<dynamic> foodList = [];
  List<dynamic> filteredFood = [];
  bool isFetching = true;
  void getDetails() async {
    await login();
    await getContractorToken();
    await getContractorName();
    await fetchFood();
  }

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  Future fetchFood() async {
    await getAllFood().then((data) {
      setState(() {
        foodList = data;
        isFetching = false;
      });
    });
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    //Selected index in navbar
    setState(() {
      _selectedIndex = index;
    });
  }

  String searchValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17181D),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             ContractorHeader(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 26, 16, 33),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) async => {
                      filteredFood = await searchFood(value),
                      setState(
                        () {
                          searchValue = value;
                          foodList = filteredFood;
                        },
                      ),
                    },
                    style: const TextStyle(color: Color(0xFFBDBDBD)),
                    decoration: InputDecoration(
                        filled: true,
                        prefixIcon:
                            const Icon(Icons.search, color: Color(0xFF757575)),
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
              children: isFetching
                  ? []
                  : (searchValue.isNotEmpty ? filteredFood : foodList)
                      .map((food) {
                      String foodName = food['name'] ?? '';
                      int foodPrice = food['price'] ?? 0;
                      String id = food['_id'];
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 33),
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
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                        left: 60,
                                        right: 60.0,
                                        top: 0,
                                        bottom: 0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 243.0,
                                      // child: foodImage == null
                                      //     ? Image.asset('assets/food.jfif',
                                      //         fit: BoxFit.fitWidth)
                                      //     : Image.file(foodImage,
                                      //         fit: BoxFit.fitWidth),
                                    ),
                                  ),
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

                                          bool confirmed = await showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return const DeleteFood();
                                            },
                                          );
                                          //Remove food item
                                          if (confirmed == true) {
                                            await deleteFood(id);
                                            getAllFood().then((data) {
                                              setState(() {
                                                foodList = data;
                                              });
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
    );
  }
}
