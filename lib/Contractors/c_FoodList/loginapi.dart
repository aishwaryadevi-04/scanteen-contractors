import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

String apiUrl = dotenv.get("API_URL", fallback: "API Doesnot exist");
String contractorToken =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb250cmFjdG9ySWQiOiI2NDhkNWIzYTU3NWM1MDU0NmI0ZWQ2M2IiLCJpYXQiOjE2ODcyNDE0OTh9.HbHQHKKRJRSR-ufYfkdVFyjjLejci8SkiXMHgTrvjFw';

Future<List<dynamic>> login() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    final response = await post(Uri.parse('$apiUrl/Contractors/login'), body: {
      "contractorCode": "abcxyz",
      "contractorPhoneNumber": 7894561230.toString(),
      "contractorPassword": "abcd1234"
    });
    

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final encodedData = jsonEncode(responseData);
      await prefs.setString('contractor details', encodedData);
      print('Response body: $responseData');
    }
  } catch (error) {
    print(error);
  }
  return [];
}
