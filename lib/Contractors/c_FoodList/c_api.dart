import 'dart:convert';
import 'package:http/http.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

String apiUrl = dotenv.get("API_URL", fallback: "API Doesnot exist");
String contractorToken = "";

Future <String> getContractorToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? contractorDetails = prefs.getString('contractor details');

  if (contractorDetails != null) {
    Map<String, dynamic> contractorData = jsonDecode(contractorDetails);
    contractorToken = contractorData['token'];
  }
  return contractorToken;
}

//Get all food
Future<List<dynamic>> getAllFood() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? foodListData = prefs.getString('foodList');
  if (foodListData != null) {
    final decodedData = jsonDecode(foodListData);
    if (decodedData is List<dynamic>) {
      return decodedData;
    }
  }

  try {
    final response =
        await get(Uri.parse('$apiUrl/Contractors/getAllfood'), headers: {
      'Authorization': 'Bearer $contractorToken',
    });

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final encodedData = jsonEncode(responseData);
      await prefs.setString('foodList', encodedData);
      print('Response body: $responseData');

      if (responseData is List<dynamic>) {
        return responseData;
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (error) {
    print('Error: $error');
  }

  return [];
}

//Search food
Future<List<dynamic>> searchFood(foodName) async {
  try {
    final response =
        await post(Uri.parse("$apiUrl/Contractors/searchFood"), headers: {
      'Authorization': 'Bearer $contractorToken',
    }, body: {
      "foodName": foodName
    });

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('Response body: $responseData');
      List<dynamic> filteredFood = jsonDecode(response.body);
      return filteredFood;
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (error) {
    print('Error: $error');
  }
  return [];
}

//Update food details
Future<List<dynamic>> updateFood(foodDetails) async {
  try {
    final response = await post(
      Uri.parse('$apiUrl/Contractors/updateFoodDetails'),
      headers: {
        'Authorization': 'Bearer $contractorToken',
      },
      body: {
        "foodId": foodDetails['_id'].toString(),
        "name": foodDetails['name'],
        "price": foodDetails['price'].toString(),
        "status": "Active",
        "threshold": foodDetails['threshold'].toString(),
      },
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('Response body: $responseData');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<dynamic> updatedFoodList = await getAllFood();
      int index = updatedFoodList
          .indexWhere((item) => item['_id'] == foodDetails['_id']);
      if (index != -1) {
        updatedFoodList[index]['_id'] = responseData['foodId'];
        updatedFoodList[index]['name'] = responseData['name'];
        updatedFoodList[index]['price'] = int.tryParse(responseData['price']);
        updatedFoodList[index]['status'] = responseData['status'];
        updatedFoodList[index]['threshold'] =
            int.tryParse(responseData['threshold']);
      }
      final encodedData = jsonEncode(updatedFoodList);
      await prefs.setString('foodList', encodedData);
      return updatedFoodList;
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (error) {
    print('Error: $error');
  }
  return [];
}

//Delete food
Future<void> deleteFood(String id) async {
  try {
    final response = await delete(
      Uri.parse('$apiUrl/Contractors/deleteFood/$id'),
      headers: {
        'Authorization': 'Bearer $contractorToken',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('Response body: $responseData');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<dynamic> updatedFoodList = await getAllFood();
      updatedFoodList.removeWhere((item) => item['_id'] == id);
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
