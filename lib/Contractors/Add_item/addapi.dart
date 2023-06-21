import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:scanteen/Contractors/c_FoodList/c_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

String apiUrl = dotenv.get("API_URL", fallback: "API Doesnot exist");

//Add food by contractor
Future addFood(foodName, price, maxPrice) async {
  try {
    final response =
        await post(Uri.parse(apiUrl + "/Contractors/addFood"), headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb250cmFjdG9ySWQiOiI2NDhkNWIzYTU3NWM1MDU0NmI0ZWQ2M2IiLCJpYXQiOjE2ODcyNDE0OTh9.HbHQHKKRJRSR-ufYfkdVFyjjLejci8SkiXMHgTrvjFw',
    }, body: {
      "name": foodName.toString(),
      "price": price.toString(),
      "threshold": maxPrice.toString(),
      "status": "Active"
    });

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print(responseData);
      if (responseData == "Already Food exists") return "failed";
      responseData['_id'] = responseData['foodId'];
      responseData.remove('foodId');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<dynamic> updatedFoodList = await getAllFood();
      updatedFoodList.add(responseData);
      final encodedData = jsonEncode(updatedFoodList);
      await prefs.setString('foodList', encodedData);
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (error) {
    print('Error: $error');
  }
}
