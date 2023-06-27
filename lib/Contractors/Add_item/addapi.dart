import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:scanteen/Contractors/c_FoodList/c_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

String apiUrl = dotenv.get("API_URL", fallback: "API Doesnot exist");

Future<String> getToken() async {
  String contractorToken = await getContractorToken();
  return contractorToken;
}

//Add food by contractor
Future addFood(foodName, price, maxPrice) async {
  await getToken();
  try {
    final response =
        await post(Uri.parse("$apiUrl/Contractors/addFood"), headers: {
      'Authorization': 'Bearer $contractorToken',
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
